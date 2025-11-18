import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamelog/widgets/app_module_title.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_password_field.dart';
import '../../../widgets/app_text_field.dart';
import '../providers/auth_providers.dart';
import 'package:gamelog/l10n/app_localizations.dart';

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

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _performRecover() {
    // ref
    //     .read(loginControllerProvider.notifier)
    //     .login(
    //   _emailController.text.trim(),
    // );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(loginControllerProvider);
    final l10n = AppLocalizations.of(context)!;
    final step = ref.watch(recoverPasswordControllerProvider);

    ref.listen<AsyncValue<void>>(loginControllerProvider, (previous, next) {
      if (next is AsyncError) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.error.toString())));
      }
      if (next is AsyncData) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('¡Login exitoso!')));
      }
    });

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
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (step == 1)
                SingleChildScrollView(
                  child: RecoverStepOne(
                    emailController: _emailController,
                    onRecover: _performRecover,
                  ),
                ),

              if (step == 2)
                SingleChildScrollView(
                  child: RecoverStepTwo(
                    verificationCodeController: _verificationCodeController,
                    onRecover: _performRecover,
                  ),
                ),

              if (step == 3)
                SingleChildScrollView(
                  child: RecoverStepThree(
                    newPasswordController: _newPasswordController,
                    onRecover: _performRecover,
                  ),
                ),

              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      text: step != 2 ? l10n.ok : l10n.verify,
                      type: step == 2
                          ? AppButtonType.success
                          : AppButtonType.primary,
                      onPressed: () {
                        if (step < 3) {
                          ref
                            .read(recoverPasswordControllerProvider.notifier)
                            .next();
                        } else {
                          //todo
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
                                recoverPasswordControllerProvider.notifier,
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
  final VoidCallback onRecover;

  const RecoverStepOne({
    super.key,
    required this.emailController,
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
          label: l10n.email,
          icon: Icons.email,
          controller: emailController,
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
