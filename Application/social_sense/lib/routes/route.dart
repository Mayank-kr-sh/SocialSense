import 'package:get/get.dart';
import 'package:social_sense/routes/route_names.dart';
import 'package:social_sense/views/auth/login.dart';
import 'package:social_sense/views/auth/register.dart';
import 'package:social_sense/views/home.dart';

class Routes {
  static final pages = [
    GetPage(name: RouteNames.home, page: () => const Home()),
    GetPage(
        name: RouteNames.login,
        page: () => const LoginScreen(),
        transition: Transition.cupertino),
    GetPage(
        name: RouteNames.register,
        page: () => const RegisterScreen(),
        transition: Transition.cupertino)
  ];
}
