import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamelog/features/auth/providers/auth_providers.dart';
import 'package:gamelog/features/review_management/models/review_game_request.dart';
import 'package:gamelog/features/review_management/models/review_game_response.dart';
import 'package:gamelog/features/review_management/providers/review_mangament_controller.dart';

import 'package:gamelog/l10n/app_localizations.dart';
import 'package:gamelog/l10n/app_localizations_extension.dart';

import '../../../core/domain/entities/game.dart';
import '../../../core/domain/failures/failure.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_global_loader.dart';
import '../../../widgets/app_icon_button.dart';
import '../../../widgets/app_module_title.dart';
import '../../../widgets/app_start_rating.dart';
import '../../../widgets/app_text_area.dart';

class ReviewGameScreen extends ConsumerStatefulWidget {
  final Game game;

  const ReviewGameScreen({super.key, required this.game});

  @override
  ConsumerState<ReviewGameScreen> createState() => _ReviewGameScreenState();
}

class _ReviewGameScreenState extends ConsumerState<ReviewGameScreen> {
  double currentRating = 0.0;

  final _opinionController = TextEditingController();

  void _performReviewGame() async {
    final request = ReviewGameRequest(
      idGame: widget.game.id,
      idPlayer: ref.read(currentUserProvider.notifier).state!.idPlayer,
      rating: currentRating,
      opinion: _opinionController.text,
      name: widget.game.name,
      released: widget.game.released!
    );

    await ref.read(reviewGameControllerProvider.notifier).reviewGame(request);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    ref.listen<AsyncValue<ReviewGameResponse?>>(reviewGameControllerProvider, (
      previous,
      next,
    ) {
      if (previous?.isLoading == true && next.isLoading == false) {
        next.when(
          loading: () {},
          data: (response) {
            ref.read(globalLoadingProvider.notifier).state = false;

            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(response!.message)));

              Navigator.pop(context);
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
    });

    return Scaffold(
      appBar: AppBar(
        leading: AppIconButton(
          icon: Icons.arrow_back,
          onPressed: () => Navigator.pop(context),
        ),
        title: AppModuleTitle(title: l10n.reviewGameTitle),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 16.0),

              Align(
                alignment: Alignment.centerLeft,
                child: AppModuleTitle(title: widget.game.name),
              ),

              Align(
                alignment: Alignment.centerLeft,
                child: Text("${l10n.rating}:",),
              ),

              Row(
                children: [
                  AppStarRating(
                    rating: currentRating,
                    onRatingChanged: (value) {
                      setState(() {
                        currentRating = value!;
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(currentRating.toString()),
                    ),
                  ),
                ],
              ),

              Divider(color: Colors.grey),

              AppTextArea(
                hint: l10n.writeOpinion,
                maxLength: 250,
                controller: _opinionController,
                onChanged: (text) {},

              ),

              Row(
                children: [
                  Expanded(
                    child: AppButton(text: l10n.ok, onPressed: () {
                      _performReviewGame();
                    }),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: AppButton(
                      text: l10n.cancel,
                      type: AppButtonType.cancel,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
