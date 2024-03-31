import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class CommentsController extends GetxController {
  var commentLoading = false.obs;
  final TextEditingController commentController =
      TextEditingController(text: '');
  final RxBool isCommenting = false.obs;
  var comments = ''.obs;

  @override
  void onClose() {
    commentController.dispose();
    super.onClose();
  }

  void postComment() {
    isCommenting.value = true;
    Future.delayed(const Duration(seconds: 2), () {
      isCommenting.value = false;
      Get.back();
    });
  }
}
