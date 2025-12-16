import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamelog/features/review_management/models/add_to_pendings_request.dart';
import 'package:gamelog/features/review_management/models/add_to_pendings_response.dart';
import 'package:gamelog/features/review_management/providers/add_game_to_pendings_controller.dart';
import 'package:gamelog/features/review_management/views/player_reviews_screen.dart';
import 'package:gamelog/features/review_management/views/review_game_screen.dart';

import 'package:gamelog/l10n/app_localizations.dart';
import 'package:gamelog/l10n/app_localizations_extension.dart';

import '../../../core/domain/entities/game.dart';
import '../../../core/domain/failures/failure.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_expandable_html_text.dart';
import '../../../widgets/app_global_loader.dart';
import '../../../widgets/app_icon_button.dart';
import '../../../widgets/app_module_title.dart';
import '../../../widgets/app_start_rating.dart';

import 'package:flutter_html/flutter_html.dart';

import '../../auth/providers/auth_providers.dart';

class GameScreen extends ConsumerStatefulWidget {
  final Game game;

  const GameScreen({super.key, required this.game});

  @override
  ConsumerState<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    void _performAddGameToPendings() async {
      final request = AddToPendingsRequest(
        idGame: widget.game.id,
        idPlayer: ref.read(currentUserProvider.notifier).state!.idPlayer,
      );

      await ref
          .read(addGameToPendingsControllerProvider.notifier)
          .addGameToPendings(request);
    }

    ref.listen<AsyncValue<AddToPendingsResponse?>>(
      addGameToPendingsControllerProvider,
      (previous, next) {
        if (previous?.isLoading == true && next.isLoading == false) {
          next.when(
            loading: () {},
            data: (response) {
              ref.read(globalLoadingProvider.notifier).state = false;

              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(response!.message)));
              });
            },
            error: (error, stack) {
              ref.read(globalLoadingProvider.notifier).state = false;

              final msg = error is Failure
                  ? (error.serverMessage ?? l10n.byKey(error.code))
                  : error.toString();

              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(msg)));
            },
          );
        }

        if (next.isLoading) {
          ref.read(globalLoadingProvider.notifier).state = true;
        }
      },
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: AppIconButton(
          icon: Icons.arrow_back,
          onPressed: () => Navigator.pop(context),
        ),
        title: AppModuleTitle(title: l10n.gameTitle),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
          child: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 150,
                    height: 150,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: widget.game.backgroundImage != null
                          ? Image.network(
                              widget.game.backgroundImage!,
                              fit: BoxFit.cover,
                            )
                          : Container(
                              color: Colors.grey.shade300,
                              child: const Icon(
                                Icons.videogame_asset,
                                size: 48,
                              ),
                            ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: AppModuleTitle(title: widget.game.name),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 4.0,
                  vertical: 8.0,
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(l10n.globalRating),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        style: TextStyle(fontWeight: FontWeight.bold),
                        widget.game.rating.toString(),
                      ),
                    ),
                  ],
                ),
              ),

              AppStarRating(rating: widget.game.rating, onRatingChanged: null),

              const SizedBox(height: 16.0),

              Padding(
                padding: const EdgeInsets.all(4),
                child: AppExpandableHtmlText(
                  html: widget.game.description ?? '',
                ),
              ),

              Divider(color: Colors.grey),

              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      text: l10n.reviewGame,
                      type: AppButtonType.success,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ReviewGameScreen(game: widget.game),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: AppButton(
                      text: l10n.showReviews,
                      type: AppButtonType.cancel,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                PlayerReviewsScreen(game: widget.game),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16.0),

              AppButton(
                text: l10n.addToPendings,
                onPressed: () {
                  _performAddGameToPendings();
                },
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
