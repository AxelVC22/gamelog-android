import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamelog/features/user_management/models/edit_profile_request.dart';
import 'package:gamelog/l10n/app_localizations_extension.dart';

import '../../../core/domain/entities/account.dart';
import '../../../core/domain/failures/failure.dart';
import '../../../core/helpers/field_state.dart';
import '../../../core/helpers/field_validator.dart';
import '../../../l10n/app_localizations.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_global_loader.dart';
import '../../../widgets/app_icon_button.dart';
import '../../../widgets/app_module_title.dart';
import '../../../widgets/app_text_field.dart';
import '../../auth/providers/auth_providers.dart';
import '../models/edit_profile_response.dart';
import '../providers/edit_profile_controller.dart';

class MyProfileScreen extends ConsumerStatefulWidget {
  const MyProfileScreen({super.key});

  @override
  ConsumerState<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends ConsumerState<MyProfileScreen> {
  bool isEditing = false;

  late final _originalMothersSurname = ref
      .read(currentUserProvider.notifier)
      .state
      ?.mothersSurname;
  late final _originalName = ref.read(currentUserProvider.notifier).state?.name;
  late final _originalFathersSurname = ref
      .read(currentUserProvider.notifier)
      .state
      ?.fathersSurname;
  late final _originalUsername = ref
      .read(currentUserProvider.notifier)
      .state
      ?.username;
  late final _originalDescription = ref
      .read(currentUserProvider.notifier)
      .state
      ?.description;


  late final TextEditingController _mothersSurnameController =
      TextEditingController(text: _originalMothersSurname);
  late final TextEditingController _nameController = TextEditingController(
    text: _originalName,
  );
  late final TextEditingController _fathersSurnameController =
      TextEditingController(text: _originalFathersSurname);
  late final TextEditingController _userNameController = TextEditingController(
    text: _originalUsername,
  );
  late final TextEditingController _descriptionController =
      TextEditingController(text: _originalDescription);

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

  void _performEdit() {
    setState(() => isEditing = true);
  }

  void _performCancel() {
    setState(() => isEditing = false);
    _mothersSurnameController.text = _originalMothersSurname!;
    _nameController.text = _originalName!;
    _fathersSurnameController.text = _originalFathersSurname!;
    _userNameController.text = _originalUsername!;
    _descriptionController.text = _originalDescription!;
  }

  void _updateProfile() {
    final newCurrentAccount = Account(
      idAccount: ref.read(currentUserProvider.notifier).state!.idAccount,
      email: ref.read(currentUserProvider.notifier).state!.email,
      status: ref.read(currentUserProvider.notifier).state!.status,
      accessType: ref.read(currentUserProvider.notifier).state!.accessType,
      idPlayer: ref.read(currentUserProvider.notifier).state!.idPlayer,
      name: _nameController.text,
      fathersSurname: _fathersSurnameController.text,
      mothersSurname: _mothersSurnameController.text,
      username: _userNameController.text,
      description: _descriptionController.text,
      picture: 'foto.jpg',
    );

    ref.read(currentUserProvider.notifier).state = newCurrentAccount;
  }

  void _performAccept() async {
    final request = EditProfileRequest(
      name: _nameController.text,
      fathersSurname: _fathersSurnameController.text,
      mothersSurname: _mothersSurnameController.text.isEmpty
          ? null
          : _mothersSurnameController.text,
      username: _userNameController.text,
      description: _descriptionController.text,
      picture: 'foto.jpg',
      idPlayer: ref.read(currentUserProvider.notifier).state?.idPlayer,
      oldEmail: ref.read(currentUserProvider.notifier).state?.email,
      userType: ref.read(currentUserProvider.notifier).state!.accessType,
    );

    await ref.read(editProfileControllerProvider.notifier).editProfile(request);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final nameError = ref.watch(nameErrorProvider);
    final fathersSurnameError = ref.watch(fathersSurnameErrorProvider);
    final mothersSurnameError = ref.watch(mothersSurnameErrorProvider);
    final usernameError = ref.watch(usernameErrorProvider);
    final descriptionError = ref.watch(descriptionErrorProvider);

    final isNameValid = ref.watch(
      nameErrorProvider.select((f) => f.isValid && f.touched),
    );
    final isFatherValid = ref.watch(
      fathersSurnameErrorProvider.select((f) => f.isValid && f.touched),
    );
    final isMotherValid = ref.watch(
      mothersSurnameErrorProvider.select((f) => f.isValid && f.touched),
    );
    final isUsernameValid = ref.watch(
      usernameErrorProvider.select((f) => f.isValid && f.touched),
    );

    final isDescriptionValid = ref.watch(
      descriptionErrorProvider.select((f) => f.isValid && f.touched),
    );


    final isValid =
        isNameValid ||
        isFatherValid ||
        isMotherValid ||
        isUsernameValid ||
        isDescriptionValid;

    ref.listen<AsyncValue<EditProfileResponse?>>(
      editProfileControllerProvider,
      (previous, next) {
        if (previous?.isLoading == true && next.isLoading == false) {
          next.when(
            loading: () {},
            data: (response) {
              ref.read(globalLoadingProvider.notifier).state = false;



              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(response!.message)));
                _updateProfile();
                //Navigator.pop(context);
                setState(() => isEditing = false);
              });
            },
            error: (error, stack) {
              ref.read(globalLoadingProvider.notifier).state = false;

              final msg = error is Failure
                  ? (error.serverMessage ?? l10n.byKey(error.code))
                  : error.toString();

              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(msg)));
              _performCancel();
            },
          );
        }

        if (next.isLoading) {
          ref.read(globalLoadingProvider.notifier).state = true;
        }
      },
    );

    return Scaffold(
      appBar: AppBar(

        title: AppModuleTitle(title: l10n.profileTitle),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Center(
                child: Image.asset('assets/images/isotipo.png', height: 150.0),
              ),
              const SizedBox(height: 16.0),
              if (isEditing)
                AppButton(
                  text: l10n.changePicture,
                  onPressed: _performEdit,
                  type: AppButtonType.primary,
                ),
              const SizedBox(height: 16.0),

              IgnorePointer(
                ignoring: !isEditing,
                child: Column(
                  children: [
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
                        notifier.state = FieldState(
                          error: error,
                          touched: true,
                        );
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
                        notifier.state = FieldState(
                          error: error,
                          touched: true,
                        );
                      },
                    ),
                    const SizedBox(height: 16.0),
                    AppTextField(
                      label: l10n.userName,
                      controller: _userNameController,
                      errorText: usernameError.error,
                      onChanged: (value) {
                        final notifier = ref.read(
                          usernameErrorProvider.notifier,
                        );

                        String? error;
                        if (value.isEmpty) {
                          error = l10n.requiredField;
                        } else if (!FieldValidator.isUsername(value)) {
                          error = l10n.invalidUsername;
                        }
                        notifier.state = FieldState(
                          error: error,
                          touched: true,
                        );
                      },
                    ),



                    const SizedBox(height: 16.0),
                    AppTextField(
                      label: l10n.description,
                      controller: _descriptionController,
                      errorText: descriptionError.error,
                      onChanged: (value) {
                        final notifier = ref.read(
                          descriptionErrorProvider.notifier,
                        );

                        String? error;
                        if (value.isEmpty) {
                          error = l10n.requiredField;
                        } else if (!FieldValidator.areLettersOnly(value)) {
                          error = l10n.invalidDescription;
                        }
                        notifier.state = FieldState(
                          error: error,
                          touched: true,
                        );
                      },
                    ),
                    const SizedBox(height: 16.0),
                  ],
                ),
              ),

              if (!isEditing)
                AppButton(
                  text: l10n.edit,
                  onPressed: _performEdit,
                  type: AppButtonType.primary,
                ),

              if (isEditing)
                Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        text: l10n.save,
                        type: AppButtonType.success,
                        onPressed: isValid ? _performAccept : null,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: AppButton(
                        text: l10n.cancel,
                        type: AppButtonType.cancel,
                        onPressed: _performCancel,
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
