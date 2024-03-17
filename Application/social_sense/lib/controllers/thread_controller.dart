import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:social_sense/controllers/user_controller.dart';
import 'package:social_sense/utils/styles/helper.dart';

class ThreadController extends GetxController {
  final TextEditingController textEditingController =
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
    textEditingController.dispose();
    super.onClose();
  }
}
