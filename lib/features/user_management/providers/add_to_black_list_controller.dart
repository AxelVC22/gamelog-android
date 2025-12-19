import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamelog/features/user_management/models/add_to_black_list_request.dart';
import 'package:gamelog/features/user_management/models/add_to_black_list_response.dart';
import 'package:gamelog/features/user_management/models/search_user_response.dart';
import 'package:gamelog/features/user_management/providers/user_management_providers.dart';
import 'package:gamelog/features/user_management/use_cases/add_to_black_list_use_case.dart';


final addToBlackListControllerProvider =
NotifierProvider<AddToBlackListController, AsyncValue<AddToBlackListResponse?>>(
  AddToBlackListController.new,
);

class AddToBlackListController extends Notifier<AsyncValue<AddToBlackListResponse?>> {
  late final AddToBlackListUseCase _addToBlackListUseCase;

  @override
  AsyncValue<AddToBlackListResponse?> build() {
    final repo = ref.read(userManagementRepositoryProvider);
    _addToBlackListUseCase = AddToBlackListUseCase(repo);
    return const AsyncData(null);
  }

  Future<AddToBlackListResponse?> addToBlackList(AddToBlackListRequest request) async {
    state = const AsyncLoading();

    final result = await _addToBlackListUseCase(request);

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
