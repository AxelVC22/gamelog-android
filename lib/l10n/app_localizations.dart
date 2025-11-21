import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('es')];

  /// No description provided for @appName.
  ///
  /// In es, this message translates to:
  /// **'Gamelog'**
  String get appName;

  /// No description provided for @appTitle.
  ///
  /// In es, this message translates to:
  /// **'Gamelog'**
  String get appTitle;

  /// No description provided for @ok.
  ///
  /// In es, this message translates to:
  /// **'Aceptar'**
  String get ok;

  /// No description provided for @cancel.
  ///
  /// In es, this message translates to:
  /// **'Cancelar'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In es, this message translates to:
  /// **'Guardar'**
  String get save;

  /// No description provided for @delete.
  ///
  /// In es, this message translates to:
  /// **'Eliminar'**
  String get delete;

  /// No description provided for @edit.
  ///
  /// In es, this message translates to:
  /// **'Editar'**
  String get edit;

  /// No description provided for @close.
  ///
  /// In es, this message translates to:
  /// **'Cerrar'**
  String get close;

  /// No description provided for @confirm.
  ///
  /// In es, this message translates to:
  /// **'Confirmar'**
  String get confirm;

  /// No description provided for @loading.
  ///
  /// In es, this message translates to:
  /// **'Cargando...'**
  String get loading;

  /// No description provided for @error.
  ///
  /// In es, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @success.
  ///
  /// In es, this message translates to:
  /// **'Éxito'**
  String get success;

  /// No description provided for @yes.
  ///
  /// In es, this message translates to:
  /// **'Sí'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In es, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @description.
  ///
  /// In es, this message translates to:
  /// **'Descripción'**
  String get description;

  /// No description provided for @search.
  ///
  /// In es, this message translates to:
  /// **'Buscar'**
  String get search;

  /// No description provided for @follow.
  ///
  /// In es, this message translates to:
  /// **'Seguir'**
  String get follow;

  /// No description provided for @friends.
  ///
  /// In es, this message translates to:
  /// **'Amigos'**
  String get friends;

  /// No description provided for @welcomeMessage.
  ///
  /// In es, this message translates to:
  /// **'¡Bienvenido, {username}!'**
  String welcomeMessage(String username);

  /// No description provided for @email.
  ///
  /// In es, this message translates to:
  /// **'Correo'**
  String get email;

  /// No description provided for @user.
  ///
  /// In es, this message translates to:
  /// **'Usuario'**
  String get user;

  /// No description provided for @password.
  ///
  /// In es, this message translates to:
  /// **'Contraseña'**
  String get password;

  /// No description provided for @name.
  ///
  /// In es, this message translates to:
  /// **'Nombre'**
  String get name;

  /// No description provided for @fathersSurname.
  ///
  /// In es, this message translates to:
  /// **'Primer apellido'**
  String get fathersSurname;

  /// No description provided for @mothersSurname.
  ///
  /// In es, this message translates to:
  /// **'Segundo apellido'**
  String get mothersSurname;

  /// No description provided for @userName.
  ///
  /// In es, this message translates to:
  /// **'Nombre de usuario'**
  String get userName;

  /// No description provided for @recoverPasswordTitle.
  ///
  /// In es, this message translates to:
  /// **'Recuperación de contraseña'**
  String get recoverPasswordTitle;

  /// No description provided for @createAccountTitle.
  ///
  /// In es, this message translates to:
  /// **'Creación de cuenta'**
  String get createAccountTitle;

  /// No description provided for @searchProfileTitle.
  ///
  /// In es, this message translates to:
  /// **'Buscar perfil'**
  String get searchProfileTitle;

  /// No description provided for @profileTitle.
  ///
  /// In es, this message translates to:
  /// **'Perfil de usuario'**
  String get profileTitle;

  /// No description provided for @editProfileTitle.
  ///
  /// In es, this message translates to:
  /// **'Editar perfil'**
  String get editProfileTitle;

  /// No description provided for @favoriteGames.
  ///
  /// In es, this message translates to:
  /// **'Videojuegos favoritos'**
  String get favoriteGames;

  /// No description provided for @searchGameTitle.
  ///
  /// In es, this message translates to:
  /// **'Buscar juego'**
  String get searchGameTitle;

  /// No description provided for @reviewGameTitle.
  ///
  /// In es, this message translates to:
  /// **'Reseñar juego'**
  String get reviewGameTitle;

  /// No description provided for @reviewHistoryTitle.
  ///
  /// In es, this message translates to:
  /// **'Historial de reseñas'**
  String get reviewHistoryTitle;

  /// No description provided for @gameTitle.
  ///
  /// In es, this message translates to:
  /// **'Juego'**
  String get gameTitle;

  /// No description provided for @myReviewTitle.
  ///
  /// In es, this message translates to:
  /// **'Mi reseña'**
  String get myReviewTitle;

  /// No description provided for @notificationsTitle.
  ///
  /// In es, this message translates to:
  /// **'Notificaciones'**
  String get notificationsTitle;

  /// No description provided for @socialTitle.
  ///
  /// In es, this message translates to:
  /// **'Social'**
  String get socialTitle;

  /// No description provided for @login.
  ///
  /// In es, this message translates to:
  /// **'Iniciar sesiôn'**
  String get login;

  /// No description provided for @createAccount.
  ///
  /// In es, this message translates to:
  /// **'Crear cuenta'**
  String get createAccount;

  /// No description provided for @recoverPassword.
  ///
  /// In es, this message translates to:
  /// **'Recuperar contraseña'**
  String get recoverPassword;

  /// No description provided for @verificationCode.
  ///
  /// In es, this message translates to:
  /// **'Código de verificación'**
  String get verificationCode;

  /// No description provided for @verify.
  ///
  /// In es, this message translates to:
  /// **'Verificar'**
  String get verify;

  /// No description provided for @register.
  ///
  /// In es, this message translates to:
  /// **'Registrar'**
  String get register;

  /// No description provided for @changePicture.
  ///
  /// In es, this message translates to:
  /// **'Cambiar foto'**
  String get changePicture;

  /// No description provided for @blackList.
  ///
  /// In es, this message translates to:
  /// **'Lista negra'**
  String get blackList;

  /// No description provided for @gameName.
  ///
  /// In es, this message translates to:
  /// **'Nombre de juego'**
  String get gameName;

  /// No description provided for @globalRating.
  ///
  /// In es, this message translates to:
  /// **'Calificación global'**
  String get globalRating;

  /// No description provided for @myRating.
  ///
  /// In es, this message translates to:
  /// **'Mi calificación'**
  String get myRating;

  /// No description provided for @reviewGame.
  ///
  /// In es, this message translates to:
  /// **'Reseñar'**
  String get reviewGame;

  /// No description provided for @showReviews.
  ///
  /// In es, this message translates to:
  /// **'Ver reseñas'**
  String get showReviews;

  /// No description provided for @rating.
  ///
  /// In es, this message translates to:
  /// **'Calificación'**
  String get rating;

  /// No description provided for @writeOpinion.
  ///
  /// In es, this message translates to:
  /// **'Escribe tu opinion'**
  String get writeOpinion;

  /// No description provided for @addToPendings.
  ///
  /// In es, this message translates to:
  /// **'Añadir a pendientes'**
  String get addToPendings;

  /// No description provided for @allReviews.
  ///
  /// In es, this message translates to:
  /// **'Todos'**
  String get allReviews;

  /// No description provided for @newFollowerNotification.
  ///
  /// In es, this message translates to:
  /// **'¡{username} ha comenzado a seguirte!'**
  String newFollowerNotification(String username);

  /// No description provided for @followers.
  ///
  /// In es, this message translates to:
  /// **'Seguidores'**
  String get followers;

  /// No description provided for @followedPlayers.
  ///
  /// In es, this message translates to:
  /// **'Seguidos'**
  String get followedPlayers;

  /// No description provided for @unexpectedError.
  ///
  /// In es, this message translates to:
  /// **'Error inesperado'**
  String get unexpectedError;

  /// No description provided for @requiredField.
  ///
  /// In es, this message translates to:
  /// **'El campo es obligatorio'**
  String get requiredField;

  /// No description provided for @invalidName.
  ///
  /// In es, this message translates to:
  /// **'El nombre es inválido'**
  String get invalidName;

  /// No description provided for @invalidFathersSurname.
  ///
  /// In es, this message translates to:
  /// **'El primer apellido es invalido'**
  String get invalidFathersSurname;

  /// No description provided for @invalidMotherSurname.
  ///
  /// In es, this message translates to:
  /// **'El segundo apellido es invalido'**
  String get invalidMotherSurname;

  /// No description provided for @invalidUsername.
  ///
  /// In es, this message translates to:
  /// **'El nombre de usuario es invalido'**
  String get invalidUsername;

  /// No description provided for @invalidPassword.
  ///
  /// In es, this message translates to:
  /// **'La contrasena no es segura'**
  String get invalidPassword;

  /// No description provided for @invalidEmail.
  ///
  /// In es, this message translates to:
  /// **'El correo es invalido'**
  String get invalidEmail;

  /// No description provided for @invalidDescription.
  ///
  /// In es, this message translates to:
  /// **'La descripcion es invalida'**
  String get invalidDescription;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
