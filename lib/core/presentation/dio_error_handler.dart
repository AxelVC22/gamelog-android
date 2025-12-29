import 'package:dio/dio.dart';

import '../domain/failures/failure.dart';

class DioErrorHandler {
  static Failure handle(dynamic error) {
    if (error is DioException) {
      return _handleDioException(error);
    }

    return Failure(
      'Ocurrió un error inesperado. Intenta nuevamente.',
     // code: 'UNEXPECTED_ERROR',
    );
  }

  static Failure _handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return Failure(
          'La conexión tardó demasiado. Verifica tu internet.',
         // code: 'TIMEOUT',
        );

      case DioExceptionType.connectionError:
        return Failure(
          'No se pudo conectar con el servidor.',
        //  code: 'NO_CONNECTION',
        );

      case DioExceptionType.badResponse:
        return _handleHttpError(e);

      case DioExceptionType.cancel:
        return Failure(
          'La solicitud fue cancelada.',
       //   code: 'REQUEST_CANCELLED',
        );

      default:
        return Failure(
          'Ocurrió un error de red inesperado.',
        //  code: 'NETWORK_ERROR',
        );
    }
  }

  static Failure _handleHttpError(DioException e) {
    final statusCode = e.response?.statusCode;
    final data = e.response?.data;

    // Si tu API manda mensajes
    final apiMessage = data is Map && data['message'] != null
        ? data['message'].toString()
        : null;

    switch (statusCode) {
      case 400:
        return Failure(
          apiMessage ?? 'La solicitud es inválida.',
        //  code: 'BAD_REQUEST',
        );
      case 401:
        return Failure(
          'Tu sesión ha expirado. Inicia sesión nuevamente.',
         // code: 'UNAUTHORIZED',
        );
      case 403:
        return Failure(
          'No tienes permisos para realizar esta acción.',
         // code: 'FORBIDDEN',
        );
      case 404:
        return Failure(
          apiMessage ?? 'No se encontró la información solicitada.',
         // code: 'NOT_FOUND',
        );
      case 500:
        return Failure(
          'Error interno del servidor. Intenta más tarde.',
          //code: 'SERVER_ERROR',
        );
      default:
        return Failure(
          apiMessage ?? 'Ocurrió un error inesperado en el servidor.',
         // code: 'HTTP_ERROR_$statusCode',
        );
    }
  }
}
