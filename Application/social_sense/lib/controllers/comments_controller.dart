import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:social_sense/controllers/login_controller.dart';
import 'package:social_sense/controllers/user_controller.dart';
import 'package:social_sense/models/post_model.dart';
import 'package:social_sense/services/socket_service.dart';
import 'package:social_sense/utils/api_endpoints.dart';
import 'package:social_sense/utils/styles/helper.dart';
import 'package:http/http.dart' as http;

class CommentsController extends GetxController {
  var commentLoading = false.obs;
  final TextEditingController commentController =
      TextEditingController(text: '');
  final RxList<String> commentsList = RxList<String>();
  final RxBool isCommenting = false.obs;
  var comments = ''.obs;
  var commentDeleted = false.obs;
  RxString newCommentNotification = ''.obs;

  @override
  void onClose() {
    commentController.dispose();
    super.onClose();
  }

  Future<void> postComment() async {
    commentLoading.value = true;
    final LoginController loginController = Get.put(LoginController());

    final token = await loginController.getToken();
    if (token == null) {
      commentLoading.value = false;
      return;
    }
    final UserController userController = Get.put(UserController());
    final user = userController.getUser;
    if (user == null) {
      commentLoading.value = false;
      showErrorDialog('User not found', 'Error');
      return;
    }
    final Post post = Get.arguments;
    if (post.id.isEmpty) {
      commentLoading.value = false;
      showErrorDialog('Post not found', 'Error');
      return;
    }
    if (commentController.text.isEmpty) {
      commentLoading.value = false;
      showErrorDialog('Comment is required', 'Error');
      return;
    }

    print(
      'user Token: $token, user Id: ${user.id}, post Id: ${post.id}, comment: ${commentController.text}',
    );

    try {
      commentLoading.value = true;
      var header = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      var url = Uri.parse(
        ApiEndPoints.baseUrl + ApiEndPoints.postEndpoints.comment + post.id,
      );

      Map<String, dynamic> body = {
        'userId': user.id,
        'text': commentController.text
      };

      // print('Comment Body: ${json.encode(body)}');

      var response = await http.post(
        url,
        headers: header,
        body: json.encode(body),
      );

      // print(response.body);

      if (response.statusCode == 200) {
        commentController.clear();
        commentLoading.value = false;
        Get.back();
        update();
      } else {
        commentLoading.value = false;
        String errorMessage =
            json.decode(response.body)['msg'] ?? 'Unknown error';
        showErrorDialog(errorMessage, 'Success');
      }
    } catch (e) {
      commentLoading.value = false;
      showErrorDialog(e.toString(), 'Error');
      print(e.toString());
    }
  }

  Future<void> deleteComment(String commentId) async {
    commentDeleted.value = true;
    final LoginController loginController = Get.put(LoginController());

    final token = await loginController.getToken();
    if (token == null) {
      commentDeleted.value = false;
      return;
    }

    final Post post = Get.arguments;
    if (post.id.isEmpty) {
      commentDeleted.value = false;
      showErrorDialog('Post not found', 'Error');
      return;
    }
    if (commentId.isEmpty) {
      commentDeleted.value = false;
      showErrorDialog('Comment not found', 'Error');
      return;
    }

    print(
      'user Token: $token, post Id: ${post.id}, comment: $commentId',
    );

    try {
      commentDeleted.value = true;
      var header = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      var url = Uri.parse(
        ApiEndPoints.baseUrl + ApiEndPoints.postEndpoints.delete + commentId,
      );

      var response = await http.delete(
        url,
        headers: header,
      );

      // print(response.body);

      if (response.statusCode == 200) {
        commentController.clear();
        commentDeleted.value = false;
        update();
      } else {
        commentDeleted.value = false;
        String errorMessage =
            json.decode(response.body)['msg'] ?? 'Unknown error';
        showErrorDialog(errorMessage, 'Success');
      }
    } catch (e) {
      commentDeleted.value = false;
      showErrorDialog(e.toString(), 'Error');
      print(e.toString());
    }
  }
}
