import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamelog/features/follows/models/follow_user_request.dart';
import 'package:gamelog/features/follows/providers/follow_user_controller.dart';
import 'package:gamelog/features/user_management/models/add_to_black_list_request.dart';
import 'package:gamelog/features/user_management/models/add_to_black_list_response.dart';
import 'package:gamelog/features/user_management/models/search_user_response.dart';
import 'package:gamelog/features/user_management/providers/add_to_black_list_controller.dart';
import 'package:gamelog/features/user_management/providers/search_user_controller.dart';

import 'package:gamelog/l10n/app_localizations.dart';

import '../../../core/domain/entities/account.dart';
import '../../../core/domain/entities/user.dart';
import '../../../core/helpers/failure_handler.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_global_loader.dart';
import '../../../widgets/app_icon_button.dart';
import '../../../widgets/app_module_title.dart';
import '../../../widgets/app_skeleton_loader.dart';
import '../../auth/providers/auth_providers.dart';
import '../../follows/models/follow_user_response.dart';

final searchResultProvider = StateProvider.autoDispose<Account?>((ref) => null);

class ProfileScreen extends ConsumerStatefulWidget {
  final String username;

  const ProfileScreen({super.key, required this.username});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  late final ProviderSubscription _searchUserSub;
  late final bool isCurrentUser =
      ref.read(currentUserProvider.notifier).state?.username == widget.username;
  late final bool isAdmin =
      ref.read(currentUserProvider.notifier).state?.accessType ==
      UserType.Administrador.name;
  bool notFoundUser = false;

  Future<void> performAddToBlackList(String email, String userType) async {
    if (!mounted) return;

    final request = AddToBlackListRequest(email: email, userType: userType);

    if (!mounted) return;
    await ref
        .read(addToBlackListControllerProvider.notifier)
        .addToBlackList(request);
  }

  Future<void> performFollowUser(int idPlayerToFollow) async {
    if (!mounted) return;

    final request = FollowUserRequest(
      idPlayerFollowed: idPlayerToFollow,
      idPlayerFollower: ref.read(currentUserProvider.notifier).state!.idPlayer,
    );

    if (!mounted) return;
    await ref.read(followUserControllerProvider.notifier).followUser(request);
  }

  @override
  void initState() {
    super.initState();

    _searchUserSub = ref.listenManual<AsyncValue<SearchUserResponse?>>(
      loadUserControllerProvider,
      _onSearchUserChanged,
    );
    Future.microtask(() => _search(widget.username));
  }

  Future<void> _search(String username) async {
    if (!mounted) return;
    ref.read(searchResultProvider.notifier).state = null;

    await ref.read(loadUserControllerProvider.notifier).searchUser(username);
  }

  @override
  void dispose() {
    _searchUserSub.close();
    super.dispose();
  }

  void _onSearchUserChanged(
    AsyncValue<SearchUserResponse?>? previous,
    AsyncValue<SearchUserResponse?> next,
  ) {
    if (!mounted) return;

    if (previous?.isLoading == true && !next.isLoading) {
      next.when(
        loading: () {},
        data: (response) {
          if (!mounted) return;

          if (response == null) return;

          if (response.accounts.first.idPlayer <= 0) {
            notFoundUser = true;
          } else {
            final notifier = ref.read(searchResultProvider.notifier);
            notifier.state = response.accounts.first;
          }
        },
        error: (error, __) {},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final user = ref.watch(searchResultProvider);

    ref.listen<AsyncValue<AddToBlackListResponse?>>(
      addToBlackListControllerProvider,
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
                Navigator.pop(context);
              });
            },
            error: (error, stack) {
              if (!mounted) return;
              ref.read(globalLoadingProvider.notifier).state = false;
              handleFailure(context: context, error: error);
            },
          );
        }
        if (next.isLoading) {
          ref.read(globalLoadingProvider.notifier).state = true;
        }
      },
    );

    ref.listen<AsyncValue<FollowUserResponse?>>(followUserControllerProvider, (
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
            if (!mounted) return;
            ref.read(globalLoadingProvider.notifier).state = false;

            handleFailure(context: context, error: error);
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
        title: AppModuleTitle(title: l10n.profileTitle),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (notFoundUser)
                Text(l10n.notFoundUser)
              else if (user == null)
                const AppSkeletonLoader(
                  height: 220,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                )
              else
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Avatar
                            CircleAvatar(
                              radius: 32,
                              backgroundImage: const AssetImage(
                                'assets/images/isotipo.png',
                              ),
                            ),
                            const SizedBox(width: 16),

                            // Info
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppModuleTitle(
                                    title:
                                        '${user.name} ${user.fathersSurname}\n (${user.username})',
                                  ),

                                  const SizedBox(height: 8),

                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            AppButton(
                                              text: l10n.follow,
                                              type: AppButtonType.primary,
                                              onPressed: () =>
                                                  performFollowUser(
                                                    user.idPlayer,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: AppButton(
                                          text: l10n.blackList,
                                          type: AppButtonType.danger,
                                          onPressed: isAdmin
                                              ? () async =>
                                                    await performAddToBlackList(
                                                      user.email!,
                                                      user.accessType!,
                                                    )
                                              : null,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            ref
                                .read(searchResultProvider.notifier)
                                .state!
                                .description,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              const SizedBox(height: 24),

              AppModuleTitle(title: l10n.favoriteGames),

              const SizedBox(height: 8),

              const Divider(),

              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
