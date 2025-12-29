import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamelog/core/data/models/follows/retrieve_social_response.dart';
import 'package:gamelog/core/data/providers/follows/follows_providers.dart';
import 'package:gamelog/features/follows/user_cases/retrieve_followed_use_case.dart';
import 'package:gamelog/features/follows/user_cases/retrieve_followers_use_case.dart';

final retrieveFollowersControllerProvider =
NotifierProvider<
    RetrieveFollowersController,
    AsyncValue<RetrieveSocialResponse?>
>(RetrieveFollowersController.new);

class RetrieveFollowersController
    extends Notifier<AsyncValue<RetrieveSocialResponse?>> {
  late final RetrieveFollowersUseCase _retrieveFollowersUseCase;

  @override
  AsyncValue<RetrieveSocialResponse?> build() {
    final repo = ref.read(followRepositoryProvider);

    _retrieveFollowersUseCase = RetrieveFollowersUseCase(repo);

    return const AsyncData(null);
  }

  Future<RetrieveSocialResponse?> retrieveFollowers(int idPlayer) async {
    state = const AsyncLoading();

    final result = await _retrieveFollowersUseCase(idPlayer);
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
