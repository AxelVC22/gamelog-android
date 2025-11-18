import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gamelog/l10n/app_localizations.dart';

import '../../../core/domain/entities/user.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_icon_button.dart';
import '../../../widgets/app_module_title.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  final User user;

  const ProfileScreen({super.key, required this.user});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  Expanded(
                    child: Image.asset(
                      'assets/images/isotipo.png',
                      height: 100.0,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        AppModuleTitle(title: widget.user.username),
                        AppButton(
                          text: l10n.follow,

                          onPressed: () {

                          },
                        ),

                        const SizedBox(height: 8.0),

                        AppButton(
                          text: l10n.blackList,
                          type: AppButtonType.danger,

                          onPressed: () {

                          },
                        ),

                      ],

                    ),
                  ),

                ],

              ),
              const SizedBox(height: 16.0),

              Text(
                widget.user.description,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54
                ),

              ),

              Divider(
                color: Colors.grey,
              ),

              AppModuleTitle(title: l10n.favoriteGames),

              Divider(
                color: Colors.grey,
              ),

              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
