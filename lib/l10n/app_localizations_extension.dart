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

    // ErrorCodes.invalidPassword: () => validationPasswordInvalid,
    // ErrorCodes.shortPassword: () => validationPasswordShort,
    //
    // // Errores de autenticación
    // ErrorCodes.userNotFound: () => errorUserNotFound,
    // ErrorCodes.wrongPassword: () => errorWrongPassword,
    // ErrorCodes.emailInUse: () => errorEmailInUse,
    //
    // // Errores de red
    // ErrorCodes.networkError: () => errorNetwork,
    // ErrorCodes.serverError: () => errorServer,
  };
}
