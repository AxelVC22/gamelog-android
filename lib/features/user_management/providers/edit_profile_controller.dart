import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamelog/features/user_management/models/edit_profile_request.dart';
import 'package:gamelog/features/user_management/models/edit_profile_response.dart';
import 'package:gamelog/features/user_management/providers/user_management_providers.dart';
import 'package:gamelog/features/user_management/use_cases/edit_profile_use_case.dart';


final editProfileControllerProvider =
NotifierProvider<EditProfileController,
    AsyncValue<EditProfileResponse?>>(
  EditProfileController.new,
);
class EditProfileController extends Notifier<
    AsyncValue< EditProfileResponse?>> {

  late final EditProfileUseCase _editProfileUseCase;

  @override
  AsyncValue<EditProfileResponse?> build() {
    final repo = ref.read(userManagementRepositoryProvider);
    _editProfileUseCase = EditProfileUseCase(repo);

    return const AsyncData(null);
  }

  Future<void> editProfile(EditProfileRequest request) async {
    state = const AsyncLoading();

    final result = await _editProfileUseCase(request);

    state = result.fold(
        (f) => AsyncError(f, StackTrace.current),
        (r) => AsyncData(r));
  }
}
