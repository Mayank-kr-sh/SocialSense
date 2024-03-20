import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_sense/controllers/login_controller.dart';
import 'package:social_sense/models/post_model.dart';
import 'package:social_sense/utils/api_endpoints.dart';
import 'package:social_sense/utils/styles/helper.dart';

class HomeController extends GetxController {
  var loading = false.obs;
  final LoginController loginController = Get.find<LoginController>();
  RxList<PostModel> posts = RxList<PostModel>();

  @override
  void onInit() async {
    await fetchPost();
    super.onInit();
  }

  Future<void> fetchPost() async {
    try {
      loading.value = true;
      final token = await loginController.getToken();
      // print('user Token, $token');
      await Future.delayed(const Duration(seconds: 2));

      // Fetch post

      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      var url = Uri.parse(
        ApiEndPoints.baseUrl + ApiEndPoints.userEndpoints.fetch,
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
        print('First Post User Name: ${posts[0].posts[2].user.name}');
        print('Data loaded successfully!');
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
