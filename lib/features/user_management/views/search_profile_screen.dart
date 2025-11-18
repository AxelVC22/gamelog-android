import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamelog/features/user_management/views/profile_screen.dart';

import 'package:gamelog/l10n/app_localizations.dart';

import '../../../core/domain/entities/user.dart';
import '../../../widgets/app_icon_button.dart';
import '../../../widgets/app_module_title.dart';
import '../../../widgets/app_search_bar.dart';
import '../../../widgets/app_profile_card.dart';

class SearchProfileScreen extends ConsumerStatefulWidget {
  const SearchProfileScreen({super.key});

  @override
  ConsumerState<SearchProfileScreen> createState() =>
      _SearchProfileScreenState();
}

class _SearchProfileScreenState extends ConsumerState<SearchProfileScreen> {
  final _searchingStringController = TextEditingController();

  List<User> allProfiles = [
    new User (username: 'Carlos', accessType: '', description: 'god del gaming mexicano xddddd'),
    new User (username: 'Ana', accessType: '', description: 'experto en resenas'),
    new User (username: 'Pedro', accessType: '', description: 'jugador casual')
  ];

  List<User> results = [];
  bool isLoading = false;

  Future<void> _search(String query) async {
    setState(() => isLoading = true);

    // Simula un delay de API
    await Future.delayed(const Duration(milliseconds: 600));

    setState(() {
      results = allProfiles
          .where((user) => user.username.toLowerCase().contains(query.toLowerCase()))
          .toList();

      isLoading = false;
    });
  }


  @override
  void dispose() {
    _searchingStringController.dispose();
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
        title: AppModuleTitle(title: l10n.searchProfileTitle),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: <Widget>[
              AppSearchBar(
                hint: l10n.search,
                onSearch: _search,
              ),

              const SizedBox(height: 12),

              if (isLoading)
                const Expanded(
                  child: Center(child: CircularProgressIndicator()),
                )
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: results.length,
                    itemBuilder: (_, i) {
                      return AppProfileCard(
                        name: results[i].username,
                        imageUrl: "",
                        onTap: () { Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>  ProfileScreen(user: results[i]),
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
