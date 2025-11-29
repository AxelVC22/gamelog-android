import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamelog/core/domain/entities/review.dart';
import 'package:gamelog/features/review_management/views/review_game_screen.dart';

import 'package:gamelog/l10n/app_localizations.dart';

import '../../../widgets/app_button.dart';
import '../../../widgets/app_icon_button.dart';
import '../../../widgets/app_module_title.dart';
import '../../../widgets/app_start_rating.dart';
import '../../../widgets/app_text_area.dart';

class ReviewScreen extends ConsumerStatefulWidget {
  final Review review;

  const ReviewScreen({super.key, required this.review});

  @override
  ConsumerState<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends ConsumerState<ReviewScreen> {

  late final _opinionController = TextEditingController(text: widget.review.opinion);

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
        title: AppModuleTitle(title: l10n.myReviewTitle),
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
                        AppModuleTitle(title: 'd')//widget.review.game.name),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),

              Text(
                'd',//widget.review.game.description,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54,
                ),
              ),

              Text(l10n.myRating),

              AppStarRating(
                rating: 4,//widget.review.game.rating,
                onRatingChanged: (_) {},
              ),



              IgnorePointer(
                ignoring: true,
                child: AppTextArea(
                  hint: l10n.writeOpinion,
                  maxLength: 250,
                  onChanged: (text) {},
                  controller: _opinionController,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
