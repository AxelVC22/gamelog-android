import 'package:dartz/dartz.dart';
import 'package:gamelog/core/data/models/users/add_to_black_list_request.dart';
import 'package:gamelog/core/data/models/users/add_to_black_list_response.dart';
import 'package:gamelog/core/data/models/users/edit_profile_request.dart';
import 'package:gamelog/core/data/models/users/edit_profile_response.dart';
import 'package:gamelog/core/data/models/users/search_user_response.dart';
import '../../../domain/failures/failure.dart';


abstract class UsersRepository {

  Future<Either<Failure, SearchUserResponse>> searchUser(String username);

  Future<Either<Failure, EditProfileResponse>> editProfile(EditProfileRequest request);

  Future<Either<Failure, AddToBlackListResponse>> addToBlackList(AddToBlackListRequest request);


}