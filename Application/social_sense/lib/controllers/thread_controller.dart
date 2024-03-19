import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:social_sense/controllers/login_controller.dart';
import 'package:social_sense/controllers/user_controller.dart';
import 'package:social_sense/utils/api_endpoints.dart';
import 'package:social_sense/utils/styles/helper.dart';

class ThreadController extends GetxController {
  final TextEditingController contentController =
      TextEditingController(text: '');

  var content = ''.obs;
  var loading = false.obs;
  Rx<File?> images = Rx<File?>(null);

  void pickImage() async {
    File? file = await pickImageFromGallery();
    if (file != null) {
      images.value = file;
    }
  }

  @override
  void onClose() {
    contentController.dispose();
    super.onClose();
  }

  Future<void> uploadPost() async {
    try {
      loading.value = true;
      final LoginController loginController = Get.put(LoginController());
      final token = await loginController.getToken();
      final UserController userController = Get.put(UserController());
      final user = userController.getUser;
      if (user == null) {
        showErrorDialog('User not found', 'Error');
        return;
      }
      print('user Token, $token');
      print('user Id,${user.id}');

      if (content.value.isEmpty && images.value == null) {
        showErrorDialog('Content or image is required', 'Error');
        return;
      }

      var header = {
        'Authorization': 'Bearer $token',
      };

      var url = Uri.parse(
          ApiEndPoints.baseUrl + user.id + ApiEndPoints.userEndpoints.post);

      var request = http.MultipartRequest('POST', url);
      request.headers.addAll(header);

      // Add text content if available
      if (contentController.text.isNotEmpty) {
        request.fields['caption'] = contentController.text;
      }

      print('Caption: ${contentController.text}');
      print('Images: ${images.value}');

      if (images.value != null) {
        var imageFile = images.value!;
        // var imageName = imageFile.path.split('/').last;
        // request.fields['imageFile'] = imageFile;
        request.files.add(await http.MultipartFile.fromPath(
          'imageFile',
          imageFile.path,
          filename: 'image.jpg',
        ));
      }

      print('request: ${request.fields}');

      var response = await request.send();
      loading.value = false;
      if (response.statusCode == 200) {
        showErrorDialog('Post uploaded successfully', 'Success');
        print('Response: ${response.toString()}');
        images.value = null;
        contentController.clear();
      } else {
        // Handle error
        print('Failed to upload post: ${response.reasonPhrase}');
        showErrorDialog('Failed to upload post', 'Error');
      }
    } catch (err) {
      loading.value = false;
      print('Error: $err');
      showErrorDialog(err.toString(), 'Error');
    }
  }
}
