import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:social_sense/controllers/login_controller.dart';
import 'package:social_sense/models/auth_model.dart';
// import 'package:http/http.dart' as http;
import 'package:social_sense/models/post_model.dart';
import 'package:social_sense/models/user_model.dart';
// import 'package:social_sense/utils/api_endpoints.dart';
// import 'package:social_sense/utils/styles/helper.dart';

class UserController extends GetxController {
  // var loading = false.obs;
  final box = GetStorage();
  // final LoginController loginController = Get.find<LoginController>();
  // RxList<PostModel> postsList = RxList<PostModel>();

  void setUser(AuthModel authModel) {
    print('User data received: ${authModel.user.toJson()}');
    box.write(
        'user',
        UserModel(
          id: authModel.user.id,
          name: authModel.user.name,
          email: authModel.user.email,
          bio: authModel.user.bio,
          dob: authModel.user.dob,
        ).toJson());
  }

  UserModel? get getUser {
    final user = box.read('user');
    if (user != null) {
      return UserModel.fromJson(user);
    }
    return null;
  }

  void updateUser(UserModel user) {
    box.write('user', user.toJson());
  }

  // Future<void> fetchUserPost(String userId) async {
  //   try {
  //     final token = await loginController.getToken();
  //     // print('user Token, $token');
  //     await Future.delayed(const Duration(seconds: 2));

  //     // Fetch post

  //     var headers = {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer $token',
  //     };

  //     var url = Uri.parse(
  //       ApiEndPoints.baseUrl + ApiEndPoints.userEndpoints.fetch,
  //     );

  //     var response = await http.get(
  //       url,
  //       headers: headers,
  //     );

  //     if (response.statusCode == 200) {
  //       final jsonData = json.decode(response.body);
  //       final postModel = UserModel.fromJson(jsonData);
  //       print('Data loaded successfully!');
  //     } else {
  //       showErrorDialog('Error updating user', 'Error');
  //       print('Error: ${response.body}');
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //     showErrorDialog(e.toString(), 'Error');
  //   }
  // }
}
