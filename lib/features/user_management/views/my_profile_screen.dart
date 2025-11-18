import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/app_localizations.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_icon_button.dart';
import '../../../widgets/app_module_title.dart';
import '../../../widgets/app_password_field.dart';
import '../../../widgets/app_text_field.dart';

class MyProfileScreen extends ConsumerStatefulWidget {
  const MyProfileScreen({super.key});

  @override
  ConsumerState<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends ConsumerState<MyProfileScreen> {
  bool isEditing = false;

  final _mothersSurnameController = TextEditingController();
  final _nameController = TextEditingController();
  final _fathersSurnameController = TextEditingController();
  final _userNameController = TextEditingController();
  final _descriptionController = TextEditingController();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _performEdit() {
    setState(() => isEditing = true);
  }

  void _performCancel() {
    setState(() => isEditing = false);
  }

  void _performAccept() {
    setState(() => isEditing = false);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: AppIconButton(
          icon: Icons.arrow_back,
          onPressed: () => Navigator.pop(context),
        ),
        title: AppModuleTitle(title: l10n.profileTitle),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
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
                        onPressed: _performAccept,
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
