import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:gamelog/features/user_management/models/search_user_response.dart';
import 'package:gamelog/features/user_management/repositories/user_management_repository.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/domain/failures/failure.dart';
import '../../../core/messages/error_codes.dart';

class UserManagementRepositoryImpl implements UserManagementRepository {
  final Dio dio;
  final FlutterSecureStorage storage;

  UserManagementRepositoryImpl(this.dio, this.storage);

  @override
  Future<Either<Failure, SearchUserResponse>> searchUser(
    String username,
  ) async {
    try {final token = await storage.read(key: 'access_token');

      final response = await dio.get(
        '${ApiConstants.searchUser}/$username',
        options: Options(
          headers: {"Authorization": "Bearer $token"},
          validateStatus: (status) => status! < 600,
        ),
      );

      if (response.statusCode == 200) {
        final res = SearchUserResponse.fromJson(response.data);
        return Right(SearchUserResponse(error: false, accounts: res.accounts));
      } else {
        return Left(Failure.server(response.data['mensaje']));
      }
    } catch (e) {
      return Left(Failure(ErrorCodes.unexpectedError));
    }
  }
}
