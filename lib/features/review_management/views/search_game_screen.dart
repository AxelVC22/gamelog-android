import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamelog/core/domain/entities/game.dart';

import 'package:gamelog/l10n/app_localizations.dart';

import '../../../widgets/app_game_card.dart';
import '../../../widgets/app_icon_button.dart';
import '../../../widgets/app_module_title.dart';
import '../../../widgets/app_search_bar.dart';
import 'game_screen.dart';

class SearchGameScreen extends ConsumerStatefulWidget {
  const SearchGameScreen({super.key});

  @override
  ConsumerState<SearchGameScreen> createState() => _SearchGameScreenState();
}

class _SearchGameScreenState extends ConsumerState<SearchGameScreen> {
  final _searchingStringController = TextEditingController();

  List<Game> allGames = [
    new Game(name: 'Zelda', description: "Descripcion del juego", id: 0, rating: 4),
    new Game(name: 'GTA', description: "De disparos", id: 1, rating: 3),
    new Game(name: 'Free fire', description: "El goty", id: 2, rating: 1),
  ];

  List<Game> results = [];
  bool isLoading = false;

  Future<void> _search(String query) async {
    setState(() => isLoading = true);

    // Simula un delay de API
    await Future.delayed(const Duration(milliseconds: 600));

    setState(() {
      results = allGames
          .where(
            (game) => game.name.toLowerCase().contains(query.toLowerCase()),
          )
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
        title: AppModuleTitle(title: l10n.searchGameTitle),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: <Widget>[
              AppSearchBar(hint: l10n.search, onSearch: _search),

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
                      return AppGameCard(
                        name: results[i].name,
                        imageUrl: "",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => GameScreen(game: results[i]),
                            ),
                          );
                        },
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
