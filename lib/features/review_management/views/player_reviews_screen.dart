import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamelog/core/domain/entities/game.dart';
import 'package:gamelog/features/review_management/views/review_screen.dart';

import 'package:gamelog/l10n/app_localizations.dart';

import '../../../core/domain/entities/player.dart';
import '../../../core/domain/entities/review.dart';
import '../../../widgets/app_filter_tab.dart';
import '../../../widgets/app_icon_button.dart';
import '../../../widgets/app_module_title.dart';
import '../../../widgets/app_my_review_card.dart';
import '../../../widgets/app_review_card.dart';
import '../../../widgets/app_search_bar.dart';

class PlayerReviewsScreen extends ConsumerStatefulWidget {
  const PlayerReviewsScreen({super.key});

  @override
  ConsumerState<PlayerReviewsScreen> createState() =>
      _PlayerReviewsScreenState();
}

class _PlayerReviewsScreenState extends ConsumerState<PlayerReviewsScreen> {
  List<Review> allGames = [
    Review(
      id: 0,
      rating: 4,
      opinion: 'Buen juego',
     // game: Game(name: 'Zelda', description: "", id: 0, rating: 3.5),
      date: DateTime.now(),
      player: Player(username: 'Meka')
    ),
    Review(
      id: 0,
      rating: 3,
      opinion: 'Mal juego',
   //   game: Game(name: 'Fortinaitiz', description: "", id: 0, rating: 1.5),
      date: DateTime.now(),
        player: Player(username: 'Cachetes')

    ),
  ];

  @override
  void initState() {
    super.initState();
    _search('z');
  }

  List<Review> results = [];
  bool isLoading = false;

  Future<void> _search(String query) async {
    setState(() => isLoading = true);

    // Simula un delay de API
    await Future.delayed(const Duration(milliseconds: 600));

    // setState(() {
    //   results = allGames
    //       .where(
    //         (review) =>
    //             review.game.name.toLowerCase().contains(query.toLowerCase()),
    //       )
    //       .toList();
    //
    //   isLoading = false;
    // });
  }

  @override
  void dispose() {
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
        title: AppModuleTitle(title: l10n.reviewHistoryTitle),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: <Widget>[
              AppFilterTab(
                options: [l10n.allReviews, l10n.friends],
                onChanged: (index) {
                },
              ),
              const SizedBox(height: 16.0),


              if (isLoading)
                const Expanded(
                  child: Center(child: CircularProgressIndicator()),
                )
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: results.length,
                    itemBuilder: (_, i) {
                      return AppReviewCard(
                        date: DateTime.now(),
                        username: results[i].player.username,
                        imageUrl: "",
                        rating: results[i].rating,
                        opinion: results[i].opinion,
                        onDelete: () {},
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ReviewScreen(review: results[i]),
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
