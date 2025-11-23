import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gamelog/features/user_management/models/edit_profile_request.dart';
import 'package:gamelog/features/user_management/models/edit_profile_response.dart';

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
    try {
      final token = await storage.read(key: 'access_token');

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

  @override
  Future<Either<List<Failure>, List<EditProfileResponse>>> editProfile(
    EditProfileRequest request,
  ) async {
    final failures = <Failure>[];
    final successes = <EditProfileResponse>[];

    if (request.changeUserDate) {
      final r1 = await changeUserData(request);

      r1.fold((err) => failures.add(err), (ok) => successes.add(ok));
    }

    if (request.changePasswordOrEmail) {
      final r2 = await changePasswordOrEmail(request);

      r2.fold((err) => failures.add(err), (ok) => successes.add(ok));
    }

    if (failures.isNotEmpty) {
      return left(failures);
    }

    return right(successes);
  }

  Future<Either<Failure, EditProfileResponse>> changeUserData(
    EditProfileRequest request,
  ) async {
    try {
      final response = await dio.put(
        '${ApiConstants.editProfile}/${request.idPlayer}',
        data: request.toJson(),
        options: Options(validateStatus: (status) => status! < 600),
      );

      if (response.statusCode == 200) {
        final res = EditProfileResponse.fromJson(response.data);
        return Right(EditProfileResponse(message: res.message, error: false));
      } else {
        return Left(Failure.server(response.data['mensaje']));
      }
    } catch (e) {
      return Left(Failure(ErrorCodes.unexpectedError));
    }
  }

  Future<Either<Failure, EditProfileResponse>> changePasswordOrEmail(
    EditProfileRequest request,
  ) async {
    try {
      final response = await dio.put(
        '${ApiConstants.recoverPasswordChangePassword}/${request.idAccess}',
        data: request.toJson(),
        options: Options(validateStatus: (status) => status! < 600),
      );

      if (response.statusCode == 200) {
        final res = EditProfileResponse.fromJson(response.data);
        return Right(EditProfileResponse(message: res.message, error: false));
      } else {
        return Left(Failure.server(response.data['mensaje']));
      }
    } catch (e) {
      return Left(Failure(ErrorCodes.unexpectedError));
    }
  }
}
