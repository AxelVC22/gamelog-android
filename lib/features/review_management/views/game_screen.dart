import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamelog/features/review_management/views/player_reviews_screen.dart';
import 'package:gamelog/features/review_management/views/review_game_screen.dart';

import 'package:gamelog/l10n/app_localizations.dart';

import '../../../core/domain/entities/game.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_expandable_html_text.dart';
import '../../../widgets/app_icon_button.dart';
import '../../../widgets/app_module_title.dart';
import '../../../widgets/app_start_rating.dart';

import 'package:flutter_html/flutter_html.dart';

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

              Padding( padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
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
                            builder: (_) => PlayerReviewsScreen(),
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
                  //todo
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
