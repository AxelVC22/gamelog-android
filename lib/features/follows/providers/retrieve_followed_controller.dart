import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamelog/features/follows/models/retrieve_social_response.dart';
import 'package:gamelog/features/follows/providers/follows_providers.dart';
import 'package:gamelog/features/follows/user_cases/retrieve_followed_use_case.dart';

final retrieveFollowedControllerProvider =
    NotifierProvider<
      RetrieveFollowedController,
      AsyncValue<RetrieveSocialResponse?>
    >(RetrieveFollowedController.new);

class RetrieveFollowedController
    extends Notifier<AsyncValue<RetrieveSocialResponse?>> {
  late final RetrieveFollowedUseCase _retrieveFollowedUseCase;

  @override
  AsyncValue<RetrieveSocialResponse?> build() {
    final repo = ref.read(followRepositoryProvider);

    _retrieveFollowedUseCase = RetrieveFollowedUseCase(repo);

    return const AsyncData(null);
  }

  Future<RetrieveSocialResponse?> retrieveFollowed(int idPlayer) async {
    state = const AsyncLoading();

    final result = await _retrieveFollowedUseCase(idPlayer);
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
