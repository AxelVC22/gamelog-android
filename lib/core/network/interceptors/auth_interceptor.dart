import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gamelog/features/auth/state/auth_state.dart';

import '../../constants/api_constants.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;
  final FlutterSecureStorage storage;
  final AuthNotifier authNotifier;

  AuthInterceptor({required this.dio, required this.storage, required this.authNotifier});

  @override
  void onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    if (!options.path.contains('/gamelog/login') &&
        !options.path.contains('/gamelog/registro') ){
      final accessToken = await storage.read(key: 'access_token');
      if (accessToken != null) {
        options.headers['Authorization'] = 'Bearer $accessToken';
      }
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final refreshToken = await storage.read(key: 'refresh_token');

    if (err.response?.statusCode == 401 &&
        !err.requestOptions.path.contains('/gamelog/autenticacion') &&
        refreshToken != null &&
        refreshToken.isNotEmpty) {

      final tokens = await _refreshToken();

      if (tokens != null) {
        await storage.write(key: 'access_token', value: tokens['access_token']);
        await storage.write(key: 'refresh_token', value: tokens['refresh_token']);

        final options = err.requestOptions;
        options.headers['Authorization'] =
        'Bearer ${tokens['access_token']}';

        final response = await dio.fetch(options);
        return handler.resolve(response);
      }

      authNotifier.expired();
      return;
    }
    authNotifier.expired();

    handler.next(err);
  }




  Future<Map<String, String>?> _refreshToken() async {
    final refreshToken = await storage.read(key: 'refresh_token');

    if (refreshToken == null) {
      return null;
    }

    try {
      final refreshDio = Dio(BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        validateStatus: (s) => s != null && s < 500,
      ));

      final response = await refreshDio.post(
        ApiConstants.refreshToken,
        data: {'refresh_token': refreshToken},
      );

      if (response.statusCode == 200) {
        return {
          'access_token': response.data['access_token'],
          'refresh_token': response.data['refresh_token'],
        };
      }

      return null;

    } catch (e) {
      return null;
    }
  }

}