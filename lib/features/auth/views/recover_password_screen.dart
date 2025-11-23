import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamelog/core/domain/entities/user.dart';
import 'package:gamelog/features/auth/models/recover_password_request.dart';
import 'package:gamelog/features/auth/views/login_screen.dart';
import 'package:gamelog/l10n/app_localizations_extension.dart';
import 'package:gamelog/widgets/app_module_title.dart';
import '../../../core/domain/failures/failure.dart';
import '../../../core/helpers/field_state.dart';
import '../../../core/helpers/field_validator.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_global_loader.dart';
import '../../../widgets/app_password_field.dart';
import '../../../widgets/app_text_field.dart';
import '../models/recover_password_response.dart';
import '../providers/auth_providers.dart';
import 'package:gamelog/l10n/app_localizations.dart';

import '../providers/recover_password_controller.dart';

class RecoverPasswordScreen extends ConsumerStatefulWidget {
  const RecoverPasswordScreen({super.key});

  @override
  ConsumerState<RecoverPasswordScreen> createState() =>
      _RecoverPasswordScreenState();
}

class _RecoverPasswordScreenState extends ConsumerState<RecoverPasswordScreen> {
  final _emailController = TextEditingController();
  final _verificationCodeController = TextEditingController();
  final _newPasswordController = TextEditingController();
  late final int idAccessSaved;

  final emailErrorProvider = StateProvider<FieldState>(
    (ref) => const FieldState(),
  );

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> performSendEmail() async {
    final request = RecoverPasswordRequest(
      email: _emailController.text,
      userType: UserType.Jugador.name,
    );
    await ref
        .read(recoverPasswordControllerProvider.notifier)
        .sendEmail(request);
  }

  Future<void> performVerifyCode() async {
    final request = RecoverPasswordRequest(
      email: _emailController.text,
      userType: UserType.Jugador.name,
      code: int.parse(_verificationCodeController.text),
    );
    await ref
        .read(recoverPasswordControllerProvider.notifier)
        .verifyCode(request);
  }

  Future<void> performChangePassword() async {
    final request = RecoverPasswordRequest(
      email: _emailController.text,
      userType: UserType.Jugador.name,
      code: int.parse(_verificationCodeController.text),
      idAccess: idAccessSaved,
      password: _newPasswordController.text
    );
    await ref
        .read(recoverPasswordControllerProvider.notifier)
        .changePassword(request);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final step = ref.watch(recoverPasswordStepControllerProvider);

    final emailError = ref.watch(emailErrorProvider);

    final isEmailValid = ref.watch(emailErrorProvider.select((f) => f.isValid));

    ref.listen<AsyncValue<RecoverPasswordResponse?>>(
      recoverPasswordControllerProvider,
      (previous, next) {
        if (previous?.isLoading == true && next.isLoading == false) {
          next.when(
            loading: () {},
            data: (response) {
              ref.read(globalLoadingProvider.notifier).state = false;
              if (response == null) return;


              if (response.step! < 3) {

                final id = response.idAccess;
                if (id != null && id > 0) {
                  idAccessSaved = id;
                }

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(response.message)));

                  ref
                      .read(recoverPasswordStepControllerProvider.notifier)
                      .next();
                });
              }

              if (response.step! == 3) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(response.message)));
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                  );
                });
              }
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
        }

        if (next.isLoading) {
          ref.read(globalLoadingProvider.notifier).state = true;
        }
      },
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: AppModuleTitle(title: l10n.recoverPasswordTitle),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (step == 1)
                SingleChildScrollView(
                  child: RecoverStepOne(
                    emailController: _emailController,
                    emailError: emailError,
                    notifier: ref.read(emailErrorProvider.notifier),
                  ),
                ),

              if (step == 2)
                SingleChildScrollView(
                  child: RecoverStepTwo(
                    verificationCodeController: _verificationCodeController,
                    onRecover: performSendEmail,
                  ),
                ),

              if (step == 3)
                SingleChildScrollView(
                  child: RecoverStepThree(
                    newPasswordController: _newPasswordController,
                    onRecover: performSendEmail,
                  ),
                ),

              Row(
                children: [
                  Expanded(
                    child: Builder(
                      builder: (_) {
                        switch (step) {
                          case 1:
                            return AppButton(
                              text: l10n.ok,
                              onPressed: isEmailValid ? performSendEmail : null,
                            );
                          case 2:
                            return AppButton(
                              text: l10n.verify,
                              type: AppButtonType.success,
                              onPressed: performVerifyCode,
                            );
                          case 3:
                            return AppButton(
                              text: l10n.ok,
                              onPressed: performChangePassword,
                            );
                          default:
                            return const SizedBox.shrink();
                        }
                      },
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: AppButton(
                      text: l10n.cancel,
                      type: AppButtonType.cancel,
                      onPressed: () {
                        if (step > 1) {
                          ref
                              .read(
                                recoverPasswordStepControllerProvider.notifier,
                              )
                              .previous();
                        } else {
                          Navigator.pop(context);
                        }
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

class RecoverStepOne extends StatelessWidget {
  final TextEditingController emailController;
  final FieldState emailError;
  final StateController<FieldState> notifier;

  const RecoverStepOne({
    super.key,
    required this.emailController,
    required this.emailError,
    required this.notifier,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        AppTextField(
          label: l10n.email,
          icon: Icons.email,
          controller: emailController,
          errorText: emailError.error,
          onChanged: (value) {
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
      ],
    );
  }
}

class RecoverStepTwo extends StatelessWidget {
  final TextEditingController verificationCodeController;
  final VoidCallback onRecover;

  const RecoverStepTwo({
    super.key,
    required this.verificationCodeController,
    required this.onRecover,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        AppTextField(
          label: l10n.verificationCode,
          icon: Icons.numbers,
          controller: verificationCodeController,
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }
}

class RecoverStepThree extends StatelessWidget {
  final TextEditingController newPasswordController;
  final VoidCallback onRecover;

  const RecoverStepThree({
    super.key,
    required this.newPasswordController,
    required this.onRecover,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        AppPasswordField(
          label: l10n.password,
          hint: l10n.password,
          controller: newPasswordController,
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }
}
