import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamelog/core/domain/entities/game.dart';
import 'package:gamelog/features/review_management/providers/search_game_controller.dart';

import 'package:gamelog/l10n/app_localizations.dart';
import 'package:gamelog/widgets/app_skeleton_loader.dart';

import '../../../core/helpers/failure_handler.dart';
import '../../../widgets/app_game_card.dart';
import '../../../widgets/app_icon_button.dart';
import '../../../widgets/app_module_title.dart';
import '../../../widgets/app_search_bar.dart';
import 'game_screen.dart';

final searchResultProvider = StateProvider<Game?>((ref) => null);

class SearchGameScreen extends ConsumerStatefulWidget {
  const SearchGameScreen({super.key});

  @override
  ConsumerState<SearchGameScreen> createState() => _SearchGameScreenState();
}

class _SearchGameScreenState extends ConsumerState<SearchGameScreen> {
  bool notFoundResults = false;

  Future<void> _search(String query) async {
    setState(() => notFoundResults = false);
    ref.read(searchResultProvider.notifier).state = null;

    if (query.isNotEmpty) {
      await ref.read(searchGameControllerProvider.notifier).searchGame(query);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final results = ref.watch(searchResultProvider);

    ref.listen<AsyncValue<Game?>>(searchGameControllerProvider, (
      previous,
      next,
    ) {
      if (previous?.isLoading == true && next.isLoading == false) {
        next.when(
          loading: () {},
          data: (response) {

            if (response == null) return;
            if (response.id <= 0) {
              setState(() => notFoundResults = true);
            } else {
              ref.read(searchResultProvider.notifier).state = response;
            }
          },
          error: (error, stack) {
            setState(() => notFoundResults = true);
            handleFailure(context: context, error: error);
          },
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: AppModuleTitle(title: l10n.searchGameTitle),
        centerTitle: true,
        elevation: 0,
        leading: AppIconButton(
          icon: Icons.arrow_back,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              AppSearchBar(hint: l10n.search, onSearch: _search),

              const SizedBox(height: 12),

              if (notFoundResults)
                Text('Sin resultados')
              else if (results == null)
                AppSkeletonLoader(height: 200)
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (_, i) {
                      return AppGameCard(
                        name: ref
                            .read(searchResultProvider.notifier)
                            .state!
                            .name,
                        imageUrl:
                            ref
                                .read(searchResultProvider.notifier)
                                .state!
                                .backgroundImage ??
                            'https://picsum.photos/800/450',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => GameScreen(
                                game: ref
                                    .read(searchResultProvider.notifier)
                                    .state!,
                              ),
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
