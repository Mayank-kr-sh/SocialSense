import 'dart:convert';
import 'dart:io';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:social_sense/controllers/login_controller.dart';
import 'package:social_sense/controllers/user_controller.dart';
import 'package:social_sense/models/user_model.dart';
import 'package:social_sense/utils/api_endpoints.dart';
import 'package:social_sense/utils/styles/helper.dart';

class ProfileController extends GetxController {
  var loading = false.obs;
  Rx<File?> image = Rx<File?>(null);
  final box = GetStorage();

  // pick the image
  void pickImage() async {
    loading.value = true;
    final File? img = await pickImageFromGallery();
    if (img != null) {
      image.value = img;
    }
    loading.value = false;
  }

  Future<void> updateUser(
      String bio, String name, String number, String dob) async {
    try {
      loading.value = true;
      final loginController = Get.put(LoginController());
      final token = await loginController.getToken();
      print('user Token, $token');
      await Future.delayed(const Duration(seconds: 2));
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      var url = Uri.parse(
        ApiEndPoints.baseUrl + ApiEndPoints.userEndpoints.update,
      );

      final UserController userController = Get.put(UserController());
      UserModel? currentUser = userController.getUser;
      String id = currentUser!.id;
      String? currentName = currentUser.name;

      print('User ID: $id');
      Map<String, dynamic> body = {
        'id': id,
      };

      if (name.isNotEmpty) {
        body['name'] = name;
      }
      if (bio.isNotEmpty) {
        body['bio'] = bio;
      }
      if (number.isNotEmpty) {
        body['phone'] = number;
      }
      if (dob.isNotEmpty) {
        body['dob'] = dob;
      }

      var response = await http.post(
        url,
        headers: headers,
        body: json.encode(body),
      );
      if (response.statusCode == 200) {
        // print('User updated');
        UserModel user = UserModel(
          id: id,
          name: name.isNotEmpty ? name : currentUser.name,
          bio: bio.isNotEmpty ? bio : currentUser.bio,
          dob: dob.isNotEmpty ? dob : currentUser.dob,
          phone: number.isNotEmpty ? number : currentUser.phone,
        );
        loading.value = false;
        print(user.name);
        userController.updateUser(user);
        Get.back();
      } else {
        loading.value = false;
        print('Error updating user');
        print('Error updating user: ${response.body}');
        showErrorDialog('Error updating user', 'Error');
      }
    } catch (e, stackTrace) {
      loading.value = false;
      print('Error: $e');
      print('Stack trace: $stackTrace');
      showErrorDialog(e.toString(), 'Error');
    }
  }
}
