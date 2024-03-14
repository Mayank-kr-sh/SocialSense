import 'dart:convert';
import 'package:get/get.dart';
import 'package:social_sense/routes/route_names.dart';
import 'package:social_sense/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:social_sense/utils/styles/helper.dart';

class RegistrationController extends GetxController {
  var registerLoading = false.obs;
  Future<void> registerUser(String name, String email, String password) async {
    try {
      registerLoading.value = true;
      var headers = {
        'Content-Type': 'application/json',
      };
      var url = Uri.parse(
        ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.register,
      );
      Map<String, dynamic> body = {
        'name': name,
        'email': email,
        'password': password,
      };
      var response = await http.post(
        url,
        headers: headers,
        body: json.encode(body),
      );

      registerLoading.value = false;
      if (response.statusCode == 200) {
        name = '';
        email = '';
        password = '';
        Get.offAllNamed(RouteNames.login);
      } else {
        showErrorDialog(json.decode(response.body)['message'], 'Error');
      }
    } catch (e) {
      registerLoading.value = false;
      showErrorDialog(e.toString(), 'Error');
    }
  }
}
