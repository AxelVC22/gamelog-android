import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamelog/features/auth/providers/auth_providers.dart';
import 'package:gamelog/features/follows/models/retrieve_social_response.dart';
import 'package:gamelog/features/follows/providers/retrieve_followed_controller.dart';
import 'package:gamelog/features/user_management/views/search_profile_screen.dart';

import 'package:gamelog/l10n/app_localizations.dart';
import 'package:gamelog/widgets/app_follower_card.dart';
import 'package:gamelog/widgets/app_skeleton_loader.dart';

import '../../../core/domain/entities/account.dart';
import '../../../core/helpers/failure_handler.dart';
import '../../../widgets/app_filter_tab.dart';
import '../../../widgets/app_module_button.dart';
import '../../../widgets/app_module_title.dart';
import '../../follows/providers/retrieve_followers_controller.dart';
import '../../user_management/views/profile_screen.dart';

final retrieveResultsProvider = StateProvider.autoDispose<List<Account>>(
  (ref) => [],
);

class SocialScreen extends ConsumerStatefulWidget {
  const SocialScreen({super.key});

  @override
  ConsumerState<SocialScreen> createState() => _SocialScreenState();
}

class _SocialScreenState extends ConsumerState<SocialScreen> {
  late final ProviderSubscription _retrieveFollowedSub;
  late final ProviderSubscription _retrieveFollowersSub;
  bool isLoading = false;
  bool notFoundResults = false;

  Future<void> _retrieveFollowed() async {
    if (!mounted) return;

    setState(() => isLoading = true);
    setState(() => notFoundResults = false);

    ref.read(retrieveResultsProvider.notifier).state = [];

    await ref
        .read(retrieveFollowedControllerProvider.notifier)
        .retrieveFollowed(
          ref.read(currentUserProvider.notifier).state!.idPlayer,
        );

    if (!mounted) return;
    setState(() => isLoading = false);
  }

  Future<void> _retrieveFollowers() async {
    if (!mounted) return;

    setState(() => isLoading = true);
    setState(() => notFoundResults = false);

    ref.read(retrieveResultsProvider.notifier).state = [];


    await ref
        .read(retrieveFollowersControllerProvider.notifier)
        .retrieveFollowers(
          ref.read(currentUserProvider.notifier).state!.idPlayer,
        );

    if (!mounted) return;
    setState(() => isLoading = false);
  }

  @override
  void initState() {
    super.initState();

    _retrieveFollowedSub = ref
        .listenManual<AsyncValue<RetrieveSocialResponse?>>(
          retrieveFollowedControllerProvider,
          _onRetrieveFollowedChanged,
        );
    _retrieveFollowersSub = ref
        .listenManual<AsyncValue<RetrieveSocialResponse?>>(
          retrieveFollowersControllerProvider,
          _onRetrieveFollowersChanged,
        );

    Future.microtask(() => _retrieveFollowed());
  }

  void _onRetrieveFollowedChanged(
    AsyncValue<RetrieveSocialResponse?>? previous,
    AsyncValue<RetrieveSocialResponse?> next,
  ) {
    if (!mounted) return;
    if (previous?.isLoading == true && !next.isLoading) {
      next.when(
        loading: () {},
        data: (response) {
          if (!mounted) return;
          if (response == null) return;

          if (response.accounts.isEmpty) {
            setState(() => notFoundResults = true);
          }
          final notifier = ref.read(retrieveResultsProvider.notifier);
          notifier.state = response.accounts;
        },
        error: (error, __) {
          if (!mounted) return;
          setState(() => notFoundResults = true);
          handleFailure(context: context, error: error);
        },
      );
    }
  }

  void _onRetrieveFollowersChanged(
    AsyncValue<RetrieveSocialResponse?>? previous,
    AsyncValue<RetrieveSocialResponse?> next,
  ) {
    if (!mounted) return;
    if (previous?.isLoading == true && !next.isLoading) {
      next.when(
        loading: () {},
        data: (response) {
          if (!mounted) return;
          if (response == null) return;

          if (response.accounts.isEmpty) {
            setState(() => notFoundResults = true);
          }
          final notifier = ref.read(retrieveResultsProvider.notifier);
          notifier.state = response.accounts;
        },
        error: (error, __) {
          if (!mounted) return;
          setState(() => notFoundResults = true);
          handleFailure(context: context, error: error);
        },
      );
    }
  }

  @override
  void dispose() {
    _retrieveFollowedSub.close();
    _retrieveFollowersSub.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final results = ref.watch(retrieveResultsProvider);

    return Scaffold(
      appBar: AppBar(
        title: AppModuleTitle(title: l10n.socialTitle),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 12.0),

              AppModuleButton(
                icon: Icons.search_outlined,
                label: l10n.searchProfileTitle,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => SearchProfileScreen()),
                  );
                },
                color: Colors.grey,
              ),
              const SizedBox(height: 12.0),

              AppFilterTab(
                options: [l10n.followedPlayers, l10n.followers],
                onChanged: (index) async {
                  switch (index) {
                    case 0:
                      await _retrieveFollowed();
                      break;
                    case 1:
                      await _retrieveFollowers();
                      break;
                  }
                },
              ),
              const SizedBox(height: 16.0),

              if (notFoundResults)
                Text('Sin resultados')
              else if (results.isEmpty)
                AppSkeletonLoader.listTile()
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: results.length,
                    itemBuilder: (_, i) {
                      return AppFollowerCard(
                        name: results[i].username,
                        imageUrl: "",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  ProfileScreen(username: results[i].username),
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
