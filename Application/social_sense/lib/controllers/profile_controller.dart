import 'dart:convert';
import 'dart:io';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:social_sense/controllers/login_controller.dart';
import 'package:social_sense/controllers/user_controller.dart';
import 'package:social_sense/models/comment_model.dart';
import 'package:social_sense/models/post_model.dart';
import 'package:social_sense/models/user_model.dart';
import 'package:social_sense/utils/api_endpoints.dart';
import 'package:social_sense/utils/styles/helper.dart';

class ProfileController extends GetxController {
  var loading = false.obs;
  Rx<File?> image = Rx<File?>(null);
  final loginController = Get.put(LoginController());
  RxList<PostModel> posts = RxList<PostModel>();
  RxList<CommentModel> comments = RxList<CommentModel>();
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

  Future<void> fetchUserPost(String userId) async {
    try {
      loading.value = true;
      final token = await loginController.getToken();
      await Future.delayed(const Duration(seconds: 2));

      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      var url = Uri.parse(
        ApiEndPoints.baseUrl + ApiEndPoints.userEndpoints.fetchSingle + userId,
      );

      var response = await http.get(
        url,
        headers: headers,
      );

      if (response.statusCode == 200) {
        loading.value = false;
        final jsonData = json.decode(response.body);
        final postModel = PostModel.fromJson(jsonData);
        posts.value = [postModel];
        print('Data loaded successfully of Particular User !');
        update();
      } else {
        loading.value = false;
        showErrorDialog('Error updating user', 'Error');
        print('Error: ${response.body}');
      }
    } catch (e) {
      loading.value = false;
      print('Error: $e');
      showErrorDialog(e.toString(), 'Error');
    }
  }

  Future<void> fetchUserComments(String userId) async {
    try {
      loading.value = true;
      final token = await loginController.getToken();
      await Future.delayed(const Duration(seconds: 2));

      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      var url = Uri.parse(
        ApiEndPoints.baseUrl + ApiEndPoints.userEndpoints.comments + userId,
      );

      var response = await http.get(
        url,
        headers: headers,
      );

      if (response.statusCode == 200) {
        loading.value = false;
        final jsonData = json.decode(response.body);

        if (jsonData['comments'] != null) {
          var fetchedComments = (jsonData['comments'] as List)
              .map((data) => CommentModel.fromJson(data))
              .toList();
          comments.assignAll(fetchedComments.reversed.toList());

          print('Comments loaded successfully !');
          update();
        } else {
          print('No comments found');
          comments.clear();
        }
      } else {
        loading.value = false;
        showErrorDialog('Error updating user', 'Error');
        print('Error: ${response.body}');
      }
    } catch (e) {
      loading.value = false;
      print('Error: $e');
      showErrorDialog(e.toString(), 'Error');
    }
  }
}
