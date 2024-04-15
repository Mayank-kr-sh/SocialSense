class ApiEndPoints {
  // static const String baseUrl = 'http://10.0.5.212:3000/api/v1/';
  static const String baseUrl = 'https://socialsense.onrender.com/api/v1/';
  static AuthEndPoint authEndpoints = AuthEndPoint();
  static UserEndPoint userEndpoints = UserEndPoint();
  static PostEndPoint postEndpoints = PostEndPoint();
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
  final String fetch = '/fetch';
  final String fetchSingle = '/fetch/';
  final String comments = 'comments/';
  final String search = 'search';
}

class PostEndPoint {
  final String comment = 'comment/';
  final String delete = '/delete/';
  final String like = '/like';
}
