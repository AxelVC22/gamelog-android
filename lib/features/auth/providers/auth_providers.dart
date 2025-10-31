import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../../core/domain/repositories/auth_repository.dart';
import '../../../../core/data/repositories/auth_repository_implementation.dart';
import '../../../../core/domain/use_cases/login_use_case.dart';
import '../../../../core/domain/entities/user.dart';

part 'auth_providers.g.dart';

@Riverpod(keepAlive: true)
FlutterSecureStorage secureStorage(SecureStorageRef ref) {
  return const FlutterSecureStorage();
}

@Riverpod(keepAlive: true)
Dio dio(DioRef ref) {
  return Dio(BaseOptions(
    baseUrl: 'https://gamelog.com/gamelogapi',
    connectTimeout: Duration(seconds: 10),
  ));
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepositoryImpl(
    ref.watch(dioProvider),
    ref.watch(secureStorageProvider),
  );
}

@Riverpod(keepAlive: true)
LoginUseCase loginUseCase(LoginUseCaseRef ref) {
  return LoginUseCase(ref.watch(authRepositoryProvider));
}

@riverpod
class LoginController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {
  }

  Future<void> login(String email, String password, String userType) async {
    final loginUseCase = ref.read(loginUseCaseProvider);
    
    state = const AsyncValue.loading();

    final result = await loginUseCase(
      email: email,
      password: password,
      userType: userType,
    );

    result.fold(
      (failure) {
        state = AsyncValue.error(failure.message, StackTrace.current);
      },
      (user) {
        state = const AsyncValue.data(null);
      },
    );
  }
}