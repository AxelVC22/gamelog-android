import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/auth/state/auth_state.dart';
import '../constants/api_constants.dart';
import '../domain/entities/account.dart';
import 'interceptors/auth_interceptor.dart';

part 'dio_client.g.dart';

final currentUserProvider = StateProvider<Account?>((ref) => null);

@riverpod
FlutterSecureStorage secureStorage(Ref ref) {
  return const FlutterSecureStorage();
}

@riverpod
Dio dio(Ref ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 10),
      validateStatus: (status) {
        if (status == null) return false;
        return status != 401;
      },
    ),
  );

  final storage = ref.read(secureStorageProvider);
  dio.interceptors.add(AuthInterceptor(dio: dio, storage: storage, authNotifier: ref.read(authStateProvider.notifier),));

  return dio;
}
