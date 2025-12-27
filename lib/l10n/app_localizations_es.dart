// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appName => 'Gamelog';

  @override
  String get appTitle => 'Gamelog';

  @override
  String get ok => 'Aceptar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get save => 'Guardar';

  @override
  String get delete => 'Eliminar';

  @override
  String get edit => 'Editar';

  @override
  String get close => 'Cerrar';

  @override
  String get confirm => 'Confirmar';

  @override
  String get loading => 'Cargando...';

  @override
  String get error => 'Error';

  @override
  String get success => 'Éxito';

  @override
  String get yes => 'Sí';

  @override
  String get no => 'No';

  @override
  String get description => 'Descripción';

  @override
  String get search => 'Buscar';

  @override
  String get follow => 'Seguir';

  @override
  String get friends => 'Amigos';

  @override
  String welcomeMessage(String username) {
    return '¡Bienvenido, $username!';
  }

  @override
  String get email => 'Correo';

  @override
  String get user => 'Usuario';

  @override
  String get password => 'Contraseña';

  @override
  String get name => 'Nombre';

  @override
  String get fathersSurname => 'Primer apellido';

  @override
  String get mothersSurname => 'Segundo apellido';

  @override
  String get userName => 'Nombre de usuario';

  @override
  String get recoverPasswordTitle => 'Recuperación de contraseña';

  @override
  String get createAccountTitle => 'Creación de cuenta';

  @override
  String get searchProfileTitle => 'Buscar perfil';

  @override
  String get profileTitle => 'Perfil de usuario';

  @override
  String get editProfileTitle => 'Editar perfil';

  @override
  String get favoriteGames => 'Videojuegos favoritos';

  @override
  String get searchGameTitle => 'Buscar juego';

  @override
  String get reviewGameTitle => 'Reseñar juego';

  @override
  String get reviewHistoryTitle => 'Historial de reseñas';

  @override
  String get reviewsTitle => 'Reseñas';

  @override
  String get gameTitle => 'Juego';

  @override
  String get myReviewTitle => 'Mi reseña';

  @override
  String get notificationsTitle => 'Notificaciones';

  @override
  String get socialTitle => 'Social';

  @override
  String get statisticsTitle => 'Estadísticas';

  @override
  String get login => 'Iniciar sesiôn';

  @override
  String get createAccount => 'Crear cuenta';

  @override
  String get recoverPassword => 'Recuperar contraseña';

  @override
  String get verificationCode => 'Código de verificación';

  @override
  String get verify => 'Verificar';

  @override
  String get register => 'Registrar';

  @override
  String get changePicture => 'Cambiar foto';

  @override
  String get blackList => 'Lista negra';

  @override
  String get gameName => 'Nombre de juego';

  @override
  String get globalRating => 'Calificación global';

  @override
  String get myRating => 'Mi calificación';

  @override
  String get reviewGame => 'Reseñar';

  @override
  String get showReviews => 'Ver reseñas';

  @override
  String get rating => 'Calificación';

  @override
  String get writeOpinion => 'Escribe tu opinion';

  @override
  String get addToPendings => 'Añadir a pendientes';

  @override
  String get allReviews => 'Todos';

  @override
  String newFollowerNotification(String username) {
    return '¡$username ha comenzado a seguirte!';
  }

  @override
  String get followers => 'Seguidores';

  @override
  String get followedPlayers => 'Seguidos';

  @override
  String get unexpectedError => 'Error inesperado';

  @override
  String get notFoundUser => 'Usuario no encontrado';

  @override
  String get requiredField => 'El campo es obligatorio';

  @override
  String get invalidName =>
      'El nombre es invalido (3-50 caracteres solo letras)';

  @override
  String get invalidGameName => 'El nombre del juego es invalido';

  @override
  String get invalidFathersSurname => 'El primer apellido es invalido';

  @override
  String get invalidMotherSurname => 'El segundo apellido es invalido';

  @override
  String get invalidUsername => 'El nombre de usuario es invalido';

  @override
  String get invalidPassword =>
      'La contrasena no es segura: procura usar mas de 8 caracteres \n Menos de 50 letras simbolos etc';

  @override
  String get invalidEmail => 'El correo es invalido';

  @override
  String get invalidDescription => 'La descripcion es invalida';

  @override
  String get nameFormat =>
      'El nombre debe ser entre 3-50 caracteres y solo debe contener letras';

  @override
  String get fathersSurnameFormat =>
      'El primer apellido debe ser entre 3-50 caracteres y solo debe contener letras';

  @override
  String get mothersSurnameFormat =>
      'El segundo apellido debe ser entre 3-50 caracteres y solo debe contener letras';

  @override
  String get usernameFormat =>
      'El nombre de usuario ser entre 3-50 caracteres y solo debe contener letras';

  @override
  String get emailFormat =>
      'El correo ser entre 3-50 caracteres y debe contener @ y .';

  @override
  String get descriptionFormat =>
      'La descripcion ser entre 3-100 caracteres y solo debe contener letras';

  @override
  String get unknownError => 'Ha ocurrido un error desconocido';
}
