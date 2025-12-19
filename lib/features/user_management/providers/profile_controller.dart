import 'package:gamelog/features/user_management/models/search_user_response.dart';
import 'package:gamelog/features/user_management/providers/user_management_providers.dart';
import 'package:gamelog/features/user_management/use_cases/search_user_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileControllerProvider =
    NotifierProvider<ProfileController, AsyncValue<SearchUserResponse?>>(
      ProfileController.new,
    );

class ProfileController extends Notifier<AsyncValue<SearchUserResponse?>> {
  late final SearchUserUseCase _searchUserUseCase;

  @override
  AsyncValue<SearchUserResponse?> build() {
    final repo = ref.read(userManagementRepositoryProvider);
    _searchUserUseCase = SearchUserUseCase(repo);
    return const AsyncData(null);
  }

  Future<void> load(String username) async {
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
