import 'package:dartz/dartz.dart';
import 'package:gamelog/features/user_management/models/edit_profile_request.dart';
import 'package:gamelog/features/user_management/models/edit_profile_response.dart';
import 'package:gamelog/features/user_management/models/search_user_response.dart';
import '../../../core/domain/failures/failure.dart';


abstract class UserManagementRepository {

  Future<Either<Failure, SearchUserResponse>> searchUser(String username);

  Future<Either<Failure, EditProfileResponse>> editProfile(EditProfileRequest request);

}