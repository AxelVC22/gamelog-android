import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamelog/core/domain/entities/game.dart';
import 'package:gamelog/features/review_management/providers/search_game_controller.dart';

import 'package:gamelog/l10n/app_localizations.dart';
import 'package:gamelog/l10n/app_localizations_extension.dart';

import '../../../core/domain/failures/failure.dart';
import '../../../widgets/app_game_card.dart';
import '../../../widgets/app_global_loader.dart';
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
  bool isLoading = false;

  Future<void> _search(String query) async {
    setState(() => isLoading = true);

    await ref.read(searchGameControllerProvider.notifier).searchGame(query);

    setState(() => isLoading = false);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    ref.listen<AsyncValue<Game?>>(searchGameControllerProvider, (
      previous,
      next,
    ) {
      if (previous?.isLoading == true && next.isLoading == false) {
        next.when(
          loading: () {},
          data: (response) {
            ref.read(globalLoadingProvider.notifier).state = false;

            if (response == null) return;

            ref.read(searchResultProvider.notifier).state = response;
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

      if (next.isLoading) {
        ref.read(globalLoadingProvider.notifier).state = true;
      }
    });

    return Scaffold(
      appBar: AppBar(
        leading: AppIconButton(
          icon: Icons.arrow_back,
          onPressed: () => Navigator.pop(context),
        ),
        title: AppModuleTitle(title: l10n.searchGameTitle),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              AppSearchBar(hint: l10n.search, onSearch: _search),

              const SizedBox(height: 12),

              if (ref.read(searchResultProvider.notifier).state != null)
                Expanded(
                  child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (_, i) {
                      return AppGameCard(
                        name: ref
                            .read(searchResultProvider.notifier)
                            .state!
                            .name, //TODO: cambiar por mejor imagen
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
