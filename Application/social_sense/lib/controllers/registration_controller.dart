import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_sense/routes/route_names.dart';
import 'package:social_sense/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;

class RegistrationController extends GetxController {
  Future<void> registerUser(String name, String email, String password) async {
    try {
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
      if (response.statusCode == 200) {
        name = '';
        email = '';
        password = '';
        Get.off(RouteNames.login);
      } else {
        Get.back();
        showDialog(
          barrierColor: const Color.fromARGB(92, 165, 147, 147),
          context: Get.context!,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: Text(json.decode(response.body)['message']),
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
    } catch (e) {
      Get.back();
      showDialog(
        barrierColor: const Color.fromARGB(92, 165, 147, 147),
        context: Get.context!,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text(e.toString()),
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
}
