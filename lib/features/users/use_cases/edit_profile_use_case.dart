import 'package:dartz/dartz.dart';
import 'package:gamelog/core/data/models/users/edit_profile_request.dart';
import 'package:gamelog/core/data/models/users/edit_profile_response.dart';
import 'package:gamelog/core/data/repositories/users/users_repository.dart';
import '../../../core/domain/failures/failure.dart';

class EditProfileUseCase {
  final UsersRepository repository;

  EditProfileUseCase(this.repository);

  Future<Either<Failure, EditProfileResponse>>call(EditProfileRequest request) async {

    //todo: validaciones
    final result = await repository.editProfile(request);

    return result;
  }
}