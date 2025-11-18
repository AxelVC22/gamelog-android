import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gamelog/l10n/app_localizations.dart';

import '../../../core/domain/entities/game.dart';
import '../../../widgets/app_button.dart';
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
        title: AppModuleTitle(title: l10n.reviewGameTitle),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 16.0),

              Text(l10n.rating),

              AppStarRating(
                rating: currentRating,
                onRatingChanged: (value) {
                  setState(() {
                    currentRating = value!;
                  });
                },
              ),

              Divider(color: Colors.grey),

              AppTextArea(
                hint: l10n.writeOpinion,
                maxLength: 250,
                onChanged: (text) {
                },
              ),


              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      text: l10n.ok,
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: AppButton(
                      text: l10n.cancel,
                      type: AppButtonType.cancel,
                      onPressed: () {},
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
