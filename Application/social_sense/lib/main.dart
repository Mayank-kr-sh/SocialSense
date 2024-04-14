import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:social_sense/controllers/login_controller.dart';
import 'package:social_sense/controllers/notification_controller.dart';
import 'package:social_sense/controllers/user_controller.dart';
import 'package:social_sense/models/notification_model.dart';
import 'package:social_sense/models/user_model.dart';
import 'package:social_sense/routes/route.dart';
import 'package:social_sense/routes/route_names.dart';
import 'package:social_sense/services/socket_service.dart';
import 'package:social_sense/theme/theme.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  final loginController = Get.put(LoginController());
  final UserController userController = Get.put(UserController());
  final NotificationController notificationController =
      Get.put(NotificationController());
  final SocketService socketService = Get.put(SocketService());

  socketService.setNotificationHandler((data) {
    print("Notification received: $data");
    notificationController.addNotification(data);
  });
  socketService.createSocketConnection();
  UserModel? currentUser = userController.getUser;
  if (currentUser != null) {
    print('User: ${currentUser.name}');
  }
  final token = await loginController.getToken();
  if (token != null) {
    loginController.startLogoutTimer(token);
  }
  runApp(MyApp(token: token));
}

class MyApp extends StatelessWidget {
  final String? token;
  const MyApp({super.key, this.token});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      getPages: Routes.pages,
      initialRoute: token != null ? RouteNames.home : RouteNames.login,
      defaultTransition: Transition.noTransition,
    );
  }
}
