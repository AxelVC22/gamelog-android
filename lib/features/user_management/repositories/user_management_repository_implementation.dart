import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gamelog/features/user_management/models/add_to_black_list_request.dart';
import 'package:gamelog/features/user_management/models/add_to_black_list_response.dart';
import 'package:gamelog/features/user_management/models/edit_profile_request.dart';
import 'package:gamelog/features/user_management/models/edit_profile_response.dart';

import 'package:gamelog/features/user_management/models/search_user_response.dart';
import 'package:gamelog/features/user_management/repositories/user_management_repository.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/domain/failures/failure.dart';
import '../../../core/messages/error_codes.dart';
import '../models/get_id_access_response.dart';

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
        return Right(res);
      } else {
        return Left(Failure.server(response.data['mensaje']));
      }
    } catch (e) {
      return Left(Failure(ErrorCodes.unexpectedError));
    }
  }

  Future<Either<Failure, EditProfileResponse>> editProfile(
    EditProfileRequest request,
  ) async {
    try {
      final token = await storage.read(key: 'access_token');
      final response = await dio.put(
        '${ApiConstants.editProfile}/${request.idPlayer}',
        data: request.toJson(),
        options: Options(
          headers: {"Authorization": "Bearer $token"},
          validateStatus: (status) => status! < 600,
        ),
      );

      if (response.statusCode == 200) {
        final res = EditProfileResponse.fromJson(response.data);
        return Right(res);
      } else {
        return Left(Failure.server(response.data['mensaje']));
      }
    } catch (e) {
      return Left(Failure(ErrorCodes.unexpectedError));
    }
  }

  Future<Either<Failure, int>> getIdAccess(
    String email,
    String userType,
  ) async {
    try {
      final response = await dio.get(
        '${ApiConstants.getIdAccess}/$email',
        queryParameters: {'tipoDeUsuario': userType},
        options: Options(validateStatus: (status) => status! < 600),
      );

      if (response.statusCode == 200) {
        final res = GetIdAccessResponse.fromJson(response.data);
        return Right(res.idAccess);
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
      final idAccess = await getIdAccess(request.oldEmail!, request.userType);

      return idAccess.fold((failure) => Left(failure), (idAccess) async {
        final response = await dio.put(
          '${ApiConstants.recoverPasswordChangePassword}/$idAccess',
          data: request.toJson(),
          options: Options(validateStatus: (status) => status! < 600),
        );

        if (response.statusCode == 200) {
          final res = EditProfileResponse.fromJson(response.data);
          return Right(res);
        } else {
          return Left(Failure.server(response.data['mensaje']));
        }
      });
    } catch (e) {
      return Left(Failure(ErrorCodes.unexpectedError));
    }
  }

  @override
  Future<Either<Failure, AddToBlackListResponse>> addToBlackList(AddToBlackListRequest request) async {
    try {
      final token = await storage.read(key: 'access_token');

      final idResult = await getIdAccess(request.email, request.userType);

      return idResult.fold(
            (failure) => Left(failure),
            (idAccess) async {
          final response = await dio.patch(
            '${ApiConstants.addToBlackList}/$idAccess',
            data: request.toJson(),
            options: Options(
              headers: {"Authorization": "Bearer $token"},
              validateStatus: (status) => status! < 600,
            ),
          );

          if (response.statusCode == 200) {
            final res = AddToBlackListResponse.fromJson(response.data);
            return Right(res);
          } else {
            final String message = response.data['mensaje'];
            return Left(Failure.server(_parseMessages(message)));
          }
        },
      );

    } catch (e) {
      return Left(Failure(ErrorCodes.unexpectedError));
    }
  }

  static String _parseMessages(dynamic message) {
    if (message == null) return '';

    if (message is String) {
      return message;
    }

    if (message is List) {
      String concatString = '';
      message.map((e) => concatString = concatString + e.toString());
      return concatString;
    }

    return ErrorCodes.unexpectedError;
  }
}
