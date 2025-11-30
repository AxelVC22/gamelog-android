import 'package:dartz/dartz.dart';
import 'package:gamelog/features/user_management/models/edit_profile_request.dart';
import 'package:gamelog/features/user_management/models/edit_profile_response.dart';
import 'package:gamelog/features/user_management/repositories/user_management_repository.dart';
import '../../../core/domain/failures/failure.dart';

class EditProfileUseCase {
  final UserManagementRepository repository;

  EditProfileUseCase(this.repository);

  Future<Either<Failure, EditProfileResponse>>call(EditProfileRequest request) async {

    //todo: validaciones
    final result = await repository.editProfile(request);

    return result;
  }
}