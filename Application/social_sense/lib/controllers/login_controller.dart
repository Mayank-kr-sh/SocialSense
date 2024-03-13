import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_sense/routes/route_names.dart';
import 'package:social_sense/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> loginUser(String email, String password) async {
    try {
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
      if (response.statusCode == 200) {
        final SharedPreferences prefs = await _prefs;
        var data = json.decode(response.body);
        var token = data['data']['token'];
        // print(token);
        // print('User email: $email');
        // print('User password: $password');
        prefs.setString('token', token);
        Get.toNamed(RouteNames.home);
      } else {
        showErrorDialog(json.decode(response.body)['message']);
      }
    } catch (e) {
      showErrorDialog(e.toString());
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

  void showErrorDialog(String message) {
    Get.back();
    showDialog(
      barrierColor: const Color.fromARGB(92, 165, 147, 147),
      context: Get.context!,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        contentPadding: const EdgeInsets.all(10),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
