import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamelog/features/user_management/models/add_to_black_list_request.dart';
import 'package:gamelog/features/user_management/models/add_to_black_list_response.dart';
import 'package:gamelog/features/user_management/models/search_user_response.dart';
import 'package:gamelog/features/user_management/providers/add_to_black_list_controller.dart';
import 'package:gamelog/features/user_management/providers/profile_controller.dart';

import 'package:gamelog/l10n/app_localizations.dart';
import 'package:gamelog/l10n/app_localizations_extension.dart';

import '../../../core/domain/entities/account.dart';
import '../../../core/domain/entities/user.dart';
import '../../../core/domain/failures/failure.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_global_loader.dart';
import '../../../widgets/app_icon_button.dart';
import '../../../widgets/app_module_title.dart';
import '../../auth/providers/auth_providers.dart';

final searchResultProvider = StateProvider<Account?>((ref) => null);

class ProfileScreen extends ConsumerStatefulWidget {
  final String username;

  const ProfileScreen({super.key, required this.username});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  late final bool isCurrentUser =
      ref.read(currentUserProvider.notifier).state?.username == widget.username;
  late final bool isAdmin =
      ref.read(currentUserProvider.notifier).state?.accessType ==
      UserType.Administrador.name;

  Future<void> performAddToBlackList(String email, String userType) async {

    final request = AddToBlackListRequest(email: email, userType: userType);

    await ref.read(addToBlackListControllerProvider.notifier).addToBlackList(request);
  }

  @override
  void initState() {
    super.initState();

    Future.microtask(() => _search(widget.username));
  }

  Future<void> _search(String username) async {
    await ref.read(profileControllerProvider.notifier).load(username);
  }

  Future<void> performFollow() async {}


  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    ref.listen<AsyncValue<AddToBlackListResponse?>>(addToBlackListControllerProvider, (
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

    ref.listen<AsyncValue<SearchUserResponse?>>(profileControllerProvider, (
      previous,
      next,
    ) {
      if (previous?.isLoading == true && next.isLoading == false) {
        next.when(
          loading: () {},
          data: (response) {
            ref.read(globalLoadingProvider.notifier).state = false;

            if (response == null) return;

            ref.read(searchResultProvider.notifier).state =
                response.accounts.first;
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
      backgroundColor: Colors.white54,
      appBar: AppBar(
        leading: AppIconButton(
          icon: Icons.arrow_back,
          onPressed: () => Navigator.pop(context),
        ),
        title: AppModuleTitle(title: l10n.profileTitle),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              if (ref.read(searchResultProvider.notifier).state == null)
                Text(l10n.notFoundUser)
              else
                Row(
                  children: [
                    Expanded(
                      //todo: cambiar por foto de perfil
                      child: Image.asset(
                        'assets/images/isotipo.png',
                        height: 60.0,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          AppModuleTitle(
                            title: ref
                                .read(searchResultProvider.notifier)
                                .state!
                                .name,
                          ),
                          AppButton(
                            text: l10n.follow,

                            onPressed: isCurrentUser ? null : performFollow,
                          ),

                          const SizedBox(height: 8.0),

                          AppButton(
                            text: l10n.blackList,
                            type: AppButtonType.danger,

                            onPressed: isAdmin ? () async => await performAddToBlackList(ref.read(searchResultProvider.notifier).state!.email, ref.read(searchResultProvider.notifier).state!.accessType) : null,
                          ),
                          const SizedBox(height: 16.0),

                          Text(
                            ref
                                .read(searchResultProvider.notifier)
                                .state!
                                .description,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

              Divider(color: Colors.grey),

              AppModuleTitle(title: l10n.favoriteGames),

              Divider(color: Colors.grey),

              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
