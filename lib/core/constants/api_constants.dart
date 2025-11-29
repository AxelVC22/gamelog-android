class ApiConstants {
  static const String baseUrl = 'http://192.168.0.31:1234'; //10.0.2.2
  static const String baseRawgUrl = 'https://api.rawg.io/api';

  //Auth
  static const String login = '/gamelog/login';
  static const String logout = '/gamelog/login/logout';

  static const String register = '/gamelog/acceso';

  static const String recoverPassword = '/gamelog/login/recuperacionDeCuenta';

  static const String recoverPasswordValidation = '/gamelog/login/recuperacionDeCuenta/validacion';

  static const String recoverPasswordChangePassword = '/gamelog/acceso';


  //username_management

  static const String searchUser = '/gamelog/jugador';

  static const String editProfile = '/gamelog/jugador';

  static const String getIdAccess = '/gamelog/acceso';

  //reviews
  static const String searchGame = '/games';
}
