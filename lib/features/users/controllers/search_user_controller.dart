import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamelog/core/data/models/users/search_user_response.dart';
import 'package:gamelog/core/data/providers/users/users_providers.dart';
import 'package:gamelog/features/users/use_cases/search_user_use_case.dart';

final loadUserControllerProvider =
NotifierProvider<SearchUserController, AsyncValue<SearchUserResponse?>>(
  SearchUserController.new,
);

final searchUserControllerProvider =
NotifierProvider<SearchUserController, AsyncValue<SearchUserResponse?>>(
  SearchUserController.new,
);

class SearchUserController extends Notifier<AsyncValue<SearchUserResponse?>> {
  late final SearchUserUseCase _searchUserUseCase;

  @override
  AsyncValue<SearchUserResponse?> build() {
    final repo = ref.read(userManagementRepositoryProvider);
    _searchUserUseCase = SearchUserUseCase(repo);
    return const AsyncData(null);
  }

  Future<SearchUserResponse?> searchUser(String username) async {
    state = const AsyncLoading();

    final result = await _searchUserUseCase(username);

    return result.fold(
          (f) {
        state = AsyncError(f, StackTrace.current);
        return null;
      },
          (r) {
        state = AsyncData(r);
        return r;
      },
    );
  }

}
