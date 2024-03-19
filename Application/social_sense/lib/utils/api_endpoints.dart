class ApiEndPoints {
  static const String baseUrl = 'http://10.0.5.212:3000/api/v1/';
  static AuthEndPoint authEndpoints = AuthEndPoint();
  static UserEndPoint userEndpoints = UserEndPoint();
}

class AuthEndPoint {
  final String register = '/';
  final String login = '/login';
  final String logout = '/auth/logout';
}

class UserEndPoint {
  final String update = '/update';
  final String get = '/user';
  final String post = '/upload';
}
