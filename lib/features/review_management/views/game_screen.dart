import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamelog/features/review_management/views/player_reviews_screen.dart';
import 'package:gamelog/features/review_management/views/review_game_screen.dart';

import 'package:gamelog/l10n/app_localizations.dart';

import '../../../core/domain/entities/game.dart';
import '../../../core/domain/entities/user.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_icon_button.dart';
import '../../../widgets/app_module_title.dart';
import '../../../widgets/app_start_rating.dart';

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
                        AppModuleTitle(title: widget.game.name),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),

              Text(
                widget.game.description,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54,
                ),
              ),

              Text(l10n.globalRating),

              AppStarRating(rating: 3.5, onRatingChanged: (_) {}),

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
