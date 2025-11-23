import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamelog/core/domain/entities/user.dart';
import 'package:gamelog/features/auth/models/login_request.dart';
import 'package:gamelog/features/auth/providers/auth_providers.dart';
import 'package:gamelog/features/auth/views/create_account_screen.dart';
import 'package:gamelog/features/auth/views/recover_password_screen.dart';
import 'package:gamelog/features/home/views/home_screen.dart';
import 'package:gamelog/l10n/app_localizations_extension.dart';
import '../../../core/domain/failures/failure.dart';
import '../../../core/helpers/field_state.dart';
import '../../../core/helpers/field_validator.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_global_loader.dart';
import '../../../widgets/app_link_text.dart';
import '../../../widgets/app_module_title.dart';
import '../../../widgets/app_password_field.dart';
import '../../../widgets/app_text_field.dart';
import '../models/login_response.dart';
import 'package:gamelog/l10n/app_localizations.dart';

import '../providers/login_controller.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
    super.dispose();
  }

  Future<void> performLogin() async {
    final request = LoginRequest(
      email: _emailController.text,
      password: _passwordController.text,
      userType: UserType.Jugador.name,
    );

    await ref.read(loginControllerProvider.notifier).login(request);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final emailError = ref.watch(emailErrorProvider);
    final passwordError = ref.watch(passwordErrorProvider);

    final isEmailValid = ref.watch(emailErrorProvider.select((f) => f.isValid));
    final isPasswordValid = ref.watch(
      passwordErrorProvider.select((f) => f.isValid),
    );

    final isValid = isEmailValid && isPasswordValid;

    ref.listen<AsyncValue<LoginResponse?>>(loginControllerProvider, (
      previous,
      next,
    ) {
      // ✅ Solo actúa si hubo un cambio real de estado
      if (previous?.isLoading == true && next.isLoading == false) {
        // Terminó de cargar (ya sea éxito o error)

        next.when(
          loading: () {}, // No hace nada, ya procesamos arriba
          data: (response) {
            ref.read(globalLoadingProvider.notifier).state = false;
            if (response == null) return;

            ref.read(currentUserProvider.notifier).state =
                response.accounts.first;

            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text("Bienvenido")));
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const HomeScreen()),
              );
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
      }

      // Muestra loading cuando empieza
      if (next.isLoading) {
        ref.read(globalLoadingProvider.notifier).state = true;
      }
    });

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Image.asset('assets/images/isotipo.png', height: 150.0),
              const SizedBox(height: 48.0),
              Center(child: AppModuleTitle(title: l10n.appName)),

              AppTextField(
                label: l10n.email,
                icon: Icons.email,
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
              const SizedBox(height: 20.0),

              AppPasswordField(
                label: l10n.password,
                hint: l10n.password,
                controller: _passwordController,
                errorText: passwordError.error,
                onChanged: (value) {
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

              Center(
                child: AppLinkText(
                  text: l10n.recoverPassword,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => RecoverPasswordScreen(),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 24.0),
              AppButton(
                text: l10n.login,

                onPressed: isValid ? () => performLogin() : null,
              ),

              const SizedBox(height: 8.0),
              AppButton(
                text: l10n.createAccount,

                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => CreateAccountScreen()),
                  );
                },
                type: AppButtonType.secondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
