import 'package:get/get.dart';

class HomeController extends GetxController {
  var loading = false.obs;

  Future<void> fetchPost() async {
    loading.value = true;
    // Fetch post

    loading.value = false;
  }
}
