import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamelog/features/auth/views/create_account_screen.dart';
import 'package:gamelog/features/auth/views/recover_password_screen.dart';
import 'package:gamelog/features/home/views/home_screen.dart';
import 'package:gamelog/features/user_management/views/search_profile_screen.dart';
import '../../../core/domain/entities/user.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_link_text.dart';
import '../../../widgets/app_module_title.dart';
import '../../../widgets/app_password_field.dart';
import '../../../widgets/app_text_field.dart';
import '../providers/auth_providers.dart';
import 'package:gamelog/l10n/app_localizations.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final List<String> _userTypes = ['Jugador', 'Administrador'];
  String? _selectedUserType;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _performLogin() {

    //todo: agregar logica

      ref.read(currentUserProvider.notifier).state = new User (username: "nombre de usuario", description: '', accessType: '');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => HomeScreen(),
        ),
      );
      return;


  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(loginControllerProvider);
    final l10n = AppLocalizations.of(context)!;

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
              ),
              const SizedBox(height: 20.0),

              AppPasswordField(
                label: l10n.password,
                hint: l10n.password,
                controller: _passwordController,
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
                isLoading: state.isLoading,
                onPressed: () {
                 _performLogin();
                },
                type: AppButtonType.primary,
              ),
              const SizedBox(height: 8.0),
              AppButton(
                text: l10n.createAccount,

                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CreateAccountScreen(),
                    ),
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
