import 'package:get/get.dart';
import 'package:social_sense/routes/route_names.dart';
import 'package:social_sense/views/auth/login.dart';
import 'package:social_sense/views/auth/register.dart';
import 'package:social_sense/views/comments/add_comments.dart';
import 'package:social_sense/views/home.dart';
import 'package:social_sense/views/profile/edit_profile.dart';

class Routes {
  static final pages = [
    GetPage(name: RouteNames.home, page: () => Home()),
    GetPage(
        name: RouteNames.login,
        page: () => const LoginScreen(),
        transition: Transition.cupertino),
    GetPage(
        name: RouteNames.register,
        page: () => const RegisterScreen(),
        transition: Transition.cupertino),
    GetPage(
        name: RouteNames.editProfile,
        page: () => const EditProfile(),
        transition: Transition.leftToRight),
    GetPage(
        name: RouteNames.addComment,
        page: () => Comments(),
        transition: Transition.downToUp),
  ];
}
