import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamelog/features/follows/models/follow_user_request.dart';
import 'package:gamelog/features/follows/models/follow_user_response.dart';
import 'package:gamelog/features/follows/models/unfollow_user_response.dart';
import 'package:gamelog/features/follows/providers/follows_providers.dart';
import 'package:gamelog/features/follows/user_cases/follow_user_use_case.dart';
import 'package:gamelog/features/follows/user_cases/unfollow_user_use_case.dart';


final unfollowUserControllerProvider =
NotifierProvider<
    UnfollowUserController,
    AsyncValue<UnfollowUserResponse?>
>(UnfollowUserController.new);

class UnfollowUserController
    extends Notifier<AsyncValue<UnfollowUserResponse?>> {
  late final UnfollowUserUseCase _unfollowUserUseCase;

  @override
  AsyncValue<UnfollowUserResponse?> build() {
    final repo = ref.read(followRepositoryProvider);

    _unfollowUserUseCase = UnfollowUserUseCase(repo);

    return const AsyncData(null);
  }

  Future<UnfollowUserResponse?> unfollowUser(int idPlayerFollower, int idPlayerFollowed) async {
    state = const AsyncLoading();

    final result = await _unfollowUserUseCase(idPlayerFollower, idPlayerFollowed);
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
