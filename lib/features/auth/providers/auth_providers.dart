import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamelog/core/constants/api_constants.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../core/domain/entities/account.dart';
import '../repositories/auth_repository.dart';
import '../repositories/auth_repository_implementation.dart';
import '../uses_cases/login_use_case.dart';
import '../../../../core/domain/entities/user.dart';

part 'auth_providers.g.dart';

final currentUserProvider = StateProvider<Account?>((ref) => null);

@Riverpod(keepAlive: true)
FlutterSecureStorage secureStorage(SecureStorageRef ref) {
  return const FlutterSecureStorage();
}

@Riverpod(keepAlive: true)
Dio dio(DioRef ref) {
  return Dio(BaseOptions(
    baseUrl: ApiConstants.baseUrl,
    connectTimeout: Duration(seconds: 10),
    receiveTimeout: Duration(seconds: 10),
    sendTimeout: Duration(seconds: 10),
  ));
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepositoryImpl(
    ref.watch(dioProvider),
    ref.watch(secureStorageProvider),
  );
}

@riverpod
class RecoverPasswordStepController extends _$RecoverPasswordStepController {
  @override
  int build() {
    return 1;
  }

  void next() {
    state = state + 1;
  }

  void previous() {
    if (state > 1) state = state - 1;
  }

  void goTo(int paso) {
    state = paso;
  }
}