class ApiConstants {
  static const String baseUrl = 'http://10.0.2.2:1234';

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
}
