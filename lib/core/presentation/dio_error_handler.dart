import 'package:dio/dio.dart';
import '../constants/error_codes.dart';
import '../domain/failures/failure.dart';

class DioErrorHandler {
  static Failure handle(dynamic error) {
    if (error is DioException) {
      return _handleDioException(error);
    }
    return const Failure.unexpected();
  }

  static Failure _handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const Failure.local(ErrorCodes.timeout);

      case DioExceptionType.connectionError:
        return const Failure.local(ErrorCodes.noConnection);

      case DioExceptionType.cancel:
        return const Failure.local(ErrorCodes.cancelled);

      case DioExceptionType.badResponse:
        return _handleHttpError(e);

      default:
        return const Failure.unexpected();
    }
  }

  static Failure _handleHttpError(DioException e) {
    final statusCode = e.response?.statusCode;
    final data = e.response?.data;

    final serverMessage = data is Map && data['mensaje'] != null
        ? data['mensaje'].toString()
        : null;

    switch (statusCode) {
      case 400:
        return const Failure.local(ErrorCodes.badRequest);

      case 401:
        return const Failure.local(ErrorCodes.unauthorized);

      case 403:
        return const Failure.local(ErrorCodes.forbidden);

      case 404:
        return const Failure.local(ErrorCodes.notFound);

      case 500:
        return Failure.server(
          serverMessage ?? 'Error interno del servidor',
        );

      default:
        return const Failure.unexpected();
    }
  }
}
