import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_sense/controllers/user_controller.dart';
import 'package:social_sense/models/auth_model.dart';
import 'package:social_sense/routes/route_names.dart';
import 'package:social_sense/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:social_sense/utils/styles/helper.dart';

class LoginController extends GetxController {
  var loginLoading = false.obs;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final UserController userController = Get.put(UserController());

  Future<void> loginUser(String email, String password) async {
    try {
      loginLoading.value = true;
      var headers = {
        'Content-Type': 'application/json',
      };
      var url = Uri.parse(
        ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.login,
      );
      Map<String, dynamic> body = {
        'email': email,
        'password': password,
      };
      var response = await http.post(
        url,
        headers: headers,
        body: json.encode(body),
      );
      loginLoading.value = false;
      if (response.statusCode == 200) {
        final SharedPreferences prefs = await _prefs;
        var data = json.decode(response.body);
        AuthModel authModel = AuthModel.fromJson(data);
        prefs.setString('token', authModel.token);
        print('Token: ${authModel.token}');
        Map<String, dynamic> userData = authModel.user.toJson();
        print('User Data: $userData');
        userController.setUser(authModel);
        Get.toNamed(RouteNames.home);
      } else {
        showErrorDialog(json.decode(response.body)['message'], 'Error');
      }
    } catch (e) {
      loginLoading.value = false;
      showErrorDialog(e.toString(), 'Error');
      print(e.toString());
    }
  }

  void saveToken(String token) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString('token', token);
  }

  Future<String?> getToken() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString('token');
  }

  Future<void> clearToken() async {
    final SharedPreferences prefs = await _prefs;
    await prefs.remove('token');
  }
}
