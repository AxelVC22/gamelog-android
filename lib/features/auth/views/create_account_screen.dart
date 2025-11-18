import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamelog/features/auth/views/recover_password_screen.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_link_text.dart';
import '../../../widgets/app_module_title.dart';
import '../../../widgets/app_password_field.dart';
import '../../../widgets/app_text_field.dart';
import '../providers/auth_providers.dart';
import 'package:gamelog/l10n/app_localizations.dart';

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

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Center(child: AppModuleTitle(title: l10n.createAccountTitle)),

              AppTextField(label: l10n.name, controller: _nameController),
              const SizedBox(height: 16.0),
              AppTextField(
                label: l10n.fathersSurname,
                controller: _fathersSurnameController,
              ),
              const SizedBox(height: 16.0),
              AppTextField(
                label: l10n.mothersSurname,
                controller: _mothersSurnameController,
              ),
              const SizedBox(height: 16.0),
              AppTextField(
                label: l10n.userName,
                controller: _userNameController,
              ),
              const SizedBox(height: 16.0),

              AppPasswordField(
                label: l10n.password,
                hint: l10n.password,
                controller: _passwordController,
              ),
              const SizedBox(height: 16.0),

              AppTextField(label: l10n.email, controller: _emailController),
              const SizedBox(height: 16.0),
              AppTextField(
                label: l10n.description,
                controller: _descriptionController,
              ),
              const SizedBox(height: 16.0),

              Row(
                children: [
                  Expanded(
                    child: AppButton(text: l10n.register, type: AppButtonType.success, onPressed: () {}),
                  ),
                  SizedBox(width: 16),
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
