import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamelog/features/review_management/models/add_to_pendings_request.dart';
import 'package:gamelog/features/review_management/models/add_to_pendings_response.dart';
import 'package:gamelog/features/review_management/providers/review_management_providers.dart';
import 'package:gamelog/features/review_management/use_cases/add_game_to_pendings_use_case.dart';


final addGameToPendingsControllerProvider =
    NotifierProvider<
      AddGameToPendingsController,
      AsyncValue<AddToPendingsResponse?>
    >(AddGameToPendingsController.new);

class AddGameToPendingsController
    extends Notifier<AsyncValue<AddToPendingsResponse?>> {
  late final AddGameToPendingsUseCase _addGameToPendingsUseCase;

  @override
  AsyncValue<AddToPendingsResponse?> build() {
    final repo = ref.read(reviewManagementRepositoryProvider);

    _addGameToPendingsUseCase = AddGameToPendingsUseCase(repo);

    return const AsyncData(null);
  }

  Future<AddToPendingsResponse?> addGameToPendings(AddToPendingsRequest request) async {
    state = const AsyncLoading();

    final result = await _addGameToPendingsUseCase(request);
    return result.fold(
      (f) {
        state = AsyncError(f, StackTrace.current);
      },
      (r) {
        state = AsyncData(r);
        return r;
      },
    );
  }
}
