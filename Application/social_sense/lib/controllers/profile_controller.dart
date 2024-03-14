import 'dart:io';

import 'package:get/get.dart';
import 'package:social_sense/utils/styles/helper.dart';

class ProfileController extends GetxController {
  var loading = false.obs;
  Rx<File?> image = Rx<File?>(null);

  // pick the image
  void pickImage() async {
    loading.value = true;
    final File? img = await pickImageFromGallery();
    if (img != null) {
      image.value = img;
    }
    loading.value = false;
  }
}
