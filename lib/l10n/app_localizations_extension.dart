import '../core/constants/error_codes.dart';
import 'app_localizations.dart';
extension AppLocalizationsDynamic on AppLocalizations {
  String byKey(String key) {
    return _translations[key]?.call() ?? unexpectedError;
  }

  Map<String, String Function()> get _translations => {

    ErrorCodes.invalidName: () => invalidName,
    ErrorCodes.invalidEmail: () => invalidEmail,
    ErrorCodes.invalidFathersSurname: () => invalidFathersSurname,
    ErrorCodes.invalidMothersSurname: () => invalidMotherSurname,
    ErrorCodes.invalidUsername: () => invalidUsername,
    ErrorCodes.invalidPassword: () => invalidPassword,
    ErrorCodes.invalidDescription: () => invalidDescription,
    ErrorCodes.invalidGameName: () => invalidGameName,
    ErrorCodes.timeout: () => timeoutError,
    ErrorCodes.noConnection: () => noConnectionError,
    ErrorCodes.cancelled: () => requestCancelled,
    ErrorCodes.badRequest: () => badRequest,
    ErrorCodes.unauthorized: () => unauthorized,
    ErrorCodes.forbidden: () => forbidden,
    ErrorCodes.notFound: () => notFound,
    ErrorCodes.serverError: () => serverError,
    ErrorCodes.unexpectedError: () => unexpectedError,
  };
}
