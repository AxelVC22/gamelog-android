import '../../constants/error_codes.dart';

class Failure {
  final String code;
  final String? serverMessage;

  const Failure(this.code, {this.serverMessage});

  const Failure.local(this.code) : serverMessage = null;

  const Failure.server(String message)
      : code = ErrorCodes.serverError,
        serverMessage = message;

  const Failure.unexpected()
      : code = ErrorCodes.unexpectedError,
        serverMessage = null;
}
