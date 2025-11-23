import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamelog/core/domain/entities/game.dart';

import 'package:gamelog/l10n/app_localizations.dart';
import 'package:gamelog/widgets/app_follower_card.dart';

import '../../../core/domain/entities/account.dart';
import '../../../core/domain/entities/player.dart';
import '../../../core/domain/entities/review.dart';
import '../../../core/domain/entities/user.dart';
import '../../../widgets/app_filter_tab.dart';
import '../../../widgets/app_icon_button.dart';
import '../../../widgets/app_module_title.dart';
import '../../user_management/views/profile_screen.dart';

class SocialScreen extends ConsumerStatefulWidget {
  const SocialScreen({super.key});

  @override
  ConsumerState<SocialScreen> createState() =>
      _SocialScreenState();
}

class _SocialScreenState extends ConsumerState<SocialScreen> {
  List<Account> allProfiles = [
    // new User (name: 'Carlos', accessType: '', description: 'god del gaming mexicano xddddd'),
    // new User (name: 'Ana', accessType: '', description: 'experto en resenas'),
    // new User (name: 'Pedro', accessType: '', description: 'jugador casual')
  ];

  @override
  void initState() {
    super.initState();
    _search('c');
  }
  List<Account> results = [];
  bool isLoading = false;


  Future<void> _search(String query) async {
    setState(() => isLoading = true);

    // Simula un delay de API
    await Future.delayed(const Duration(milliseconds: 600));

    setState(() {
      results = allProfiles
          .where((user) => user.name.toLowerCase().contains(query.toLowerCase()))
          .toList();

      isLoading = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
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
        title: AppModuleTitle(title: l10n.socialTitle),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: <Widget>[
              AppFilterTab(
                options: [l10n.followedPlayers, l10n.followers],
                onChanged: (index) {
                  print("Seleccionado: $index");
                },
              ),
              const SizedBox(height: 16.0),


              if (isLoading)
                const Expanded(
                  child: Center(child: CircularProgressIndicator()),
                )
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: results.length,
                    itemBuilder: (_, i) {
                      return AppFollowerCard(
                        name: results[i].name,
                        imageUrl: "",
                        onTap: () { Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>  ProfileScreen(account: results[i]),
                          ),
                        );},
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
