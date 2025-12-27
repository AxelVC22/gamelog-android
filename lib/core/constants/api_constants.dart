class ApiConstants {
  static const String baseUrl = 'http://192.168.0.24:1234'; //10.0.2.2
  static const String baseRawgUrl = 'https://api.rawg.io/api';

  static const String queryIdPlayerSeeker = 'idJugadorBuscador';

  //Auth
  static const String login = '/gamelog/login';
  static const String logout = '/gamelog/login/logout';

  static const String register = '/gamelog/acceso';

  static const String recoverPassword = '/gamelog/login/recuperacionDeCuenta';

  static const String recoverPasswordValidation =
      '/gamelog/login/recuperacionDeCuenta/validacion';

  static const String recoverPasswordChangePassword = '/gamelog/acceso';

  //username_management

  static const String searchUser = '/gamelog/jugador';

  static const String editProfile = '/gamelog/jugador';

  static const String addToBlackList = '/gamelog/acceso';

  static const String getIdAccess = '/gamelog/acceso';

  //reviews
  static const String searchGame = '/games';

  static const String reviewGame = '/gamelog/resena';

  static const String retrievePlayerReviews = '/gamelog/resena/juego';

  static const String retriveReviewHistory = '/gamelog/resena/jugador';

  static const String deleteReview = '/gamelog/resena';

  static const String likeReview = '/gamelog/MeGusta';

  static String retrieveFollowedPlayerReview(int idGame) =>
      '/gamelog/resena/juego/$idGame/seguidos';

  //games

  static const String registerGame = '/gamelog/juego';

  static const String addGameToPendings = '/gamelog/juego/pendiente';

  //satistics

  static const String retrieveTrendStatistics = '/gamelog/reporte/tendencias/';

  static const String retrieveRevivalRetroStatistics =
      '/gamelog/reporte/revivalretro/';

  //follow

  static const String followUser = '/gamelog/seguidor';

  static const String unfollowUser = '/gamelog/seguidor/';

  static const String retrieveFollowed = '/gamelog/seguidor/seguidos/';

  static const String retrieveFollowers = '/gamelog/seguidor/seguidores/';
}
