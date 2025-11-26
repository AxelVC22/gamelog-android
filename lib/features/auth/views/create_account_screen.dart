import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamelog/core/helpers/field_validator.dart';
import 'package:gamelog/l10n/app_localizations_extension.dart';
import '../../../core/domain/entities/user.dart';
import '../../../core/domain/failures/failure.dart';
import '../../../core/helpers/field_state.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_global_loader.dart';

import '../../../widgets/app_module_title.dart';
import '../../../widgets/app_password_field.dart';
import '../../../widgets/app_text_field.dart';
import '../models/register_user_reponse.dart';
import '../models/register_user_request.dart';
import 'package:gamelog/l10n/app_localizations.dart';
import '../providers/register_controller.dart';

class CreateAccountScreen extends ConsumerStatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  ConsumerState<CreateAccountScreen> createState() =>
      _CreateAccountScreenState();
}

class _CreateAccountScreenState extends ConsumerState<CreateAccountScreen> {
  final _mothersSurnameController = TextEditingController();
  final _nameController = TextEditingController();
  final _fathersSurnameController = TextEditingController();
  final _userNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final nameErrorProvider = StateProvider<FieldState>(
    (ref) => const FieldState(),
  );
  final fathersSurnameErrorProvider = StateProvider<FieldState>(
    (ref) => const FieldState(),
  );
  final mothersSurnameErrorProvider = StateProvider<FieldState>(
    (ref) => const FieldState(),
  );
  final usernameErrorProvider = StateProvider<FieldState>(
    (ref) => const FieldState(),
  );
  final descriptionErrorProvider = StateProvider<FieldState>(
    (ref) => const FieldState(),
  );
  final emailErrorProvider = StateProvider<FieldState>(
    (ref) => const FieldState(),
  );
  final passwordErrorProvider = StateProvider<FieldState>(
        (ref) => const FieldState(),
  );

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _userNameController.dispose();
    super.dispose();
  }

  Future<void> performCreateAccount() async {
    final request = RegisterUserRequest(
      email: _emailController.text,
      password: _passwordController.text,
      status: UserStatus.Desbaneado.name,
      name: _nameController.text,
      fathersSurname: _fathersSurnameController.text,
      mothersSurname: _mothersSurnameController.text.isEmpty
          ? null
          : _mothersSurnameController.text,
      username: _userNameController.text,
      description: _descriptionController.text,
      picture: 'foto.jpg',
      userType: UserType.Jugador.name,
    );

    await ref.read(registerControllerProvider.notifier).register(request);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final nameError = ref.watch(nameErrorProvider);
    final fathersSurnameError = ref.watch(fathersSurnameErrorProvider);
    final mothersSurnameError = ref.watch(mothersSurnameErrorProvider);
    final usernameError = ref.watch(usernameErrorProvider);
    final emailError = ref.watch(emailErrorProvider);
    final descriptionError = ref.watch(descriptionErrorProvider);
    final passwordError = ref.watch(passwordErrorProvider);

    final isNameValid = ref.watch(nameErrorProvider.select((f) => f.isValid));
    final isFatherValid = ref.watch(fathersSurnameErrorProvider.select((f) => f.isValid));
    final isMotherValid = ref.watch(mothersSurnameErrorProvider.select((f) => f.isValid));
    final isUsernameValid = ref.watch(usernameErrorProvider.select((f) => f.isValid));
    final isEmailValid = ref.watch(emailErrorProvider.select((f) => f.isValid));
    final isDescriptionValid = ref.watch(descriptionErrorProvider.select((f) => f.isValid));
    final isPasswordValid = ref.watch(passwordErrorProvider.select((f) => f.isValid));

    final isValid = isNameValid &&
        isFatherValid &&
        isMotherValid &&
        isUsernameValid &&
        isEmailValid &&
        isDescriptionValid  &&
        isPasswordValid;

    ref.listen<AsyncValue<RegisterUserResponse?>>(registerControllerProvider, (
      previous,
      next,
    ) {
      next.when(
        loading: () {
          ref.read(globalLoadingProvider.notifier).state = true;
        },
        data: (response) {
          ref.read(globalLoadingProvider.notifier).state = false;

          if (response == null) return;

          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(response.message)));

            Navigator.pop(context);
          });
        },
        error: (error, stack) {
          ref.read(globalLoadingProvider.notifier).state = false;

          final msg = error is Failure
              ? (error.serverMessage ?? l10n.byKey(error.code))
              : error.toString();


          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(msg)));
          });
        },
      );
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Center(child: AppModuleTitle(title: l10n.createAccountTitle)),

              AppTextField(
                label: l10n.name,
                controller: _nameController,
                errorText: nameError.error,
                onChanged: (value) {
                  final notifier = ref.read(nameErrorProvider.notifier);

                  String? error;
                  if (value.isEmpty) {
                    error = l10n.requiredField;
                  } else if (!FieldValidator.isName(value)) {
                    error = l10n.invalidName;
                  }

                  notifier.state = FieldState(error: error, touched: true);
                },
              ),

              const SizedBox(height: 16.0),

              AppTextField(
                label: l10n.fathersSurname,
                controller: _fathersSurnameController,
                errorText: fathersSurnameError.error,
                onChanged: (value) {
                  final notifier = ref.read(
                    fathersSurnameErrorProvider.notifier,
                  );
                  String? error;

                  if (value.isEmpty) {
                    error = l10n.requiredField;
                  } else if (!FieldValidator.isName(value)) {
                    error = l10n.invalidFathersSurname;
                  }
                  notifier.state = FieldState(error: error, touched: true);
                },
              ),
              const SizedBox(height: 16.0),
              AppTextField(
                label: l10n.mothersSurname,
                controller: _mothersSurnameController,
                errorText: mothersSurnameError.error,

                onChanged: (value) {
                  final notifier = ref.read(
                    mothersSurnameErrorProvider.notifier,
                  );

                  String? error;
                  if (value.isEmpty) {
                    error = l10n.requiredField;
                  } else if (!FieldValidator.isName(value)) {
                    error = l10n.invalidMotherSurname;
                  }
                  notifier.state = FieldState(error: error, touched: true);
                },
              ),
              const SizedBox(height: 16.0),

              AppTextField(
                label: l10n.userName,
                controller: _userNameController,
                errorText: usernameError.error,
                onChanged: (value) {
                  final notifier = ref.read(usernameErrorProvider.notifier);

                  String? error;
                  if (value.isEmpty) {
                    error = l10n.requiredField;
                  } else if (!FieldValidator.isUsername(value)) {
                    error = l10n.invalidUsername;
                  }
                  notifier.state = FieldState(error: error, touched: true);
                },
              ),
              const SizedBox(height: 16.0),

              AppPasswordField(
                label: l10n.password,
                hint: l10n.password,
                controller: _passwordController, errorText: passwordError.error,  // ← Agregar
                onChanged: (value) {              // ← Cambiar de validator a onChanged
                  final notifier = ref.read(passwordErrorProvider.notifier);

                  String? error;
                  if (value.isEmpty) {
                    error = l10n.requiredField;
                  } else if (!FieldValidator.isStrongPassword(value)) {
                    error = l10n.invalidPassword;
                  }
                  notifier.state = FieldState(error: error, touched: true);
                },
              ),
              const SizedBox(height: 16.0),

              AppTextField(
                label: l10n.email,
                controller: _emailController,
                errorText: emailError.error,
                onChanged: (value) {
                  final notifier = ref.read(emailErrorProvider.notifier);

                  String? error;
                  if (value.isEmpty) {
                    error = l10n.requiredField;
                  } else if (!FieldValidator.isEmail(value)) {
                    error = l10n.invalidEmail;
                  }
                  notifier.state = FieldState(error: error, touched: true);
                },
              ),
              const SizedBox(height: 16.0),

              AppTextField(
                label: l10n.description,
                controller: _descriptionController,
                errorText: descriptionError.error,
                onChanged: (value) {
                  final notifier = ref.read(descriptionErrorProvider.notifier);

                  String? error;
                  if (value.isEmpty) {
                    error = l10n.requiredField;
                  } else if (!FieldValidator.areLettersOnly(value)) {
                    error = l10n.invalidDescription;
                  }
                  notifier.state = FieldState(error: error, touched: true);
                },
              ),
              const SizedBox(height: 16.0),

              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      text: l10n.register,
                      type: AppButtonType.success,
                      onPressed: isValid
                          ? () async => await performCreateAccount()
                          : null,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: AppButton(
                      text: l10n.cancel,
                      type: AppButtonType.cancel,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
