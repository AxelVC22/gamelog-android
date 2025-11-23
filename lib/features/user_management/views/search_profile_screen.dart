import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamelog/features/user_management/models/search_user_response.dart';
import 'package:gamelog/features/user_management/providers/search_user_controller.dart';
import 'package:gamelog/features/user_management/views/profile_screen.dart';

import 'package:gamelog/l10n/app_localizations.dart';
import 'package:gamelog/l10n/app_localizations_extension.dart';

import '../../../core/domain/entities/account.dart';
import '../../../core/domain/entities/user.dart';
import '../../../core/domain/failures/failure.dart';
import '../../../widgets/app_global_loader.dart';
import '../../../widgets/app_icon_button.dart';
import '../../../widgets/app_module_title.dart';
import '../../../widgets/app_search_bar.dart';
import '../../../widgets/app_profile_card.dart';

final searchResultsProvider = StateProvider<List<Account>>((ref) => []);

class SearchProfileScreen extends ConsumerStatefulWidget {
  const SearchProfileScreen({super.key});

  @override
  ConsumerState<SearchProfileScreen> createState() =>
      _SearchProfileScreenState();
}

class _SearchProfileScreenState extends ConsumerState<SearchProfileScreen> {
  final _searchingStringController = TextEditingController();

  bool isLoading = false;

  Future<void> _search(String query) async {
    setState(() => isLoading = true);

    await ref.read(searchUserControllerProvider.notifier).searchUser(query);

    setState(() => isLoading = false);
  }

  @override
  void dispose() {
    _searchingStringController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final results = ref.watch(searchResultsProvider);

    ref.listen<AsyncValue<SearchUserResponse?>>(searchUserControllerProvider, (
      previous,
      next,
    ) {
      if (previous?.isLoading == true && next.isLoading == false) {
        next.when(
          loading: () {},
          data: (response) {
            ref.read(globalLoadingProvider.notifier).state = false;

            if (response == null) return;

            ref.read(searchResultsProvider.notifier).state = response.accounts;
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: AppIconButton(
          icon: Icons.arrow_back,
          onPressed: () => Navigator.pop(context),
        ),
        title: AppModuleTitle(title: l10n.searchProfileTitle),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: <Widget>[
              AppSearchBar(hint: l10n.search, onSearch: _search),

              const SizedBox(height: 12),

              if (isLoading)
                const Expanded(
                  child: Center(child: CircularProgressIndicator()),
                )
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: results.length,
                    itemBuilder: (_, i) {
                      return AppProfileCard(
                        name: results[i].username,
                        imageUrl: "",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  ProfileScreen(account: results[i]),
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
