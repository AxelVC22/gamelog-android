import 'package:dartz/dartz.dart';
import 'package:gamelog/features/auth/models/login_request.dart';
import 'package:gamelog/features/auth/models/logout_response.dart';
import 'package:gamelog/features/auth/models/recover_password_response.dart';
import 'package:gamelog/features/user_management/models/search_user_response.dart';
import '../../../core/domain/failures/failure.dart';


abstract class UserManagementRepository {

  Future<Either<Failure, SearchUserResponse>> searchUser(String username);

}