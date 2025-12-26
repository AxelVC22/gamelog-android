import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamelog/features/follows/models/follow_user_request.dart';
import 'package:gamelog/features/follows/models/follow_user_response.dart';
import 'package:gamelog/features/follows/providers/follows_providers.dart';
import 'package:gamelog/features/follows/user_cases/follow_user_use_case.dart';


final followUserControllerProvider =
NotifierProvider<
    FollowUserController,
    AsyncValue<FollowUserResponse?>
>(FollowUserController.new);

class FollowUserController
    extends Notifier<AsyncValue<FollowUserResponse?>> {
  late final FollowUserUseCase _followUserUseCase;

  @override
  AsyncValue<FollowUserResponse?> build() {
    final repo = ref.read(followRepositoryProvider);

    _followUserUseCase = FollowUserUseCase(repo);

    return const AsyncData(null);
  }

  Future<FollowUserResponse?> followUser(FollowUserRequest request) async {
    state = const AsyncLoading();

    final result = await _followUserUseCase(request);
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
