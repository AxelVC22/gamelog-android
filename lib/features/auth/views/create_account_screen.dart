import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamelog/core/helpers/field_validator.dart';
import 'package:gamelog/features/auth/views/recover_password_screen.dart';
import '../../../core/domain/entities/user.dart';
import '../../../core/helpers/field_state.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_link_text.dart';
import '../../../widgets/app_module_title.dart';
import '../../../widgets/app_password_field.dart';
import '../../../widgets/app_text_field.dart';
import '../models/register_user_request.dart';
import '../providers/auth_providers.dart';
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
  final fathersSurnameErrorProvider = StateProvider<String?>((ref) => null);
  final mothersSurnameErrorProvider = StateProvider<String?>((ref) => null);
  final usernameErrorProvider = StateProvider<String?>((ref) => null);
  final descriptionErrorProvider = StateProvider<String?>((ref) => null);
  final emailErrorProvider = StateProvider<String?>((ref) => null);
  final passwordErrorProvider = StateProvider<String?>((ref) => null);

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _userNameController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final request = RegisterUserRequest( email: _emailController.text, password: _passwordController.text, status: 'Desbaneado', name: _nameController.text, fathersSurname: _fathersSurnameController.text, mothersSurname: _mothersSurnameController.text.isEmpty ? null : _mothersSurnameController.text, username: _userNameController.text, description: _descriptionController.text, picture: 'foto.jpg', userType: 'Jugador', ); await ref.read(registerControllerProvider.notifier).register(request);
  }

  Future<void> performCreateAccount() async {
    final request = RegisterUserRequest(
      email: _emailController.text,
      password: _passwordController.text,
      status: UserStatus.Desbaneado.toString(),
      name: _nameController.text,
      fathersSurname: _fathersSurnameController.text,
      mothersSurname: _mothersSurnameController.text.isEmpty
          ? null
          : _mothersSurnameController.text,
      username: _userNameController.text,
      description: _descriptionController.text,
      picture: '',
      userType: UserType.Jugador.toString(),
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

    final isValid = ref.watch(nameErrorProvider.select((field) => field.isValid));


    ref.listen<AsyncValue<String?>>(registerControllerProvider, (
      previous,
      next,
    ) {
      next.when(
        data: (mensaje) {
          if (mensaje != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(mensaje)));

            print('Mensaje backend: $mensaje');

            Navigator.pop(context);
          }
        },
        loading: () {
          print('Registro en progreso...');
        },
        error: (err, stack) {
          final mensajeError = err is String ? err : err.toString();
          print('Error en registro: $mensajeError');
          print('StackTrace: $stack');

          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Error: $mensajeError')));
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

                  notifier.state = FieldState(
                    error: error,
                    touched: true,
                  );
                },
              ),



              const SizedBox(height: 16.0),

              AppTextField(
                label: l10n.fathersSurname,
                controller: _fathersSurnameController,
                errorText: fathersSurnameError,
                onChanged: (value) {
                  final notifier = ref.read(
                    fathersSurnameErrorProvider.notifier,
                  );

                  if (value.isEmpty) {
                    notifier.state = l10n.requiredField;
                  } else if (!FieldValidator.isName(value)) {
                    notifier.state = l10n.invalidFathersSurname;
                  } else {
                    notifier.state = null;
                  }
                },
              ),
              const SizedBox(height: 16.0),
              AppTextField(
                label: l10n.mothersSurname,
                controller: _mothersSurnameController,
                errorText: mothersSurnameError,

                onChanged: (value) {
                  final notifier = ref.read(
                    mothersSurnameErrorProvider.notifier,
                  );

                  if (value.isEmpty) {
                    notifier.state = l10n.requiredField;
                  } else if (!FieldValidator.isName(value)) {
                    notifier.state = l10n.invalidMotherSurname;
                  } else {
                    notifier.state = null;
                  }
                },
              ),
              const SizedBox(height: 16.0),

              AppTextField(
                label: l10n.userName,
                controller: _userNameController,
                errorText: usernameError,
                onChanged: (value) {
                  final notifier = ref.read(
                    usernameErrorProvider.notifier,
                  );

                  if (value.isEmpty) {
                    notifier.state = l10n.requiredField;
                  } else if (!FieldValidator.isUsername(value)) {
                    notifier.state = l10n.invalidUsername;
                  } else {
                    notifier.state = null;
                  }
                },
              ),
              const SizedBox(height: 16.0),

              AppPasswordField(
                label: l10n.password,
                hint: l10n.password,
                controller: _passwordController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return l10n.requiredField;
                  }
                  if (!FieldValidator.isStrongPassword(value)) {
                    return l10n.invalidPassword;
                  }
                  return null; // Sin errores
                },
              ),
              const SizedBox(height: 16.0),

              AppTextField(
                label: l10n.email,
                controller: _emailController,
                errorText: emailError,
                onChanged: (value) {
                  final notifier = ref.read(
                    emailErrorProvider.notifier,
                  );

                  if (value.isEmpty) {
                    notifier.state = l10n.requiredField;
                  } else if (!FieldValidator.isEmail(value)) {
                    notifier.state = l10n.invalidEmail;
                  } else {
                    notifier.state = null;
                  }
                },
              ),
              const SizedBox(height: 16.0),

              AppTextField(
                label: l10n.description,
                controller: _descriptionController,
                errorText: descriptionError,
                onChanged: (value) {
                  final notifier = ref.read(
                    descriptionErrorProvider.notifier,
                  );

                  if (value.isEmpty) {
                    notifier.state = l10n.requiredField;
                  } else if (!FieldValidator.areLettersOnly(value)) {
                    notifier.state = l10n.invalidDescription;
                  } else {
                    notifier.state = null;
                  }
                },
              ),
              const SizedBox(height: 16.0),


              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      text: l10n.register,
                      type: AppButtonType.success,
                      onPressed: isValid ? () async => await _submit() : null,
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
