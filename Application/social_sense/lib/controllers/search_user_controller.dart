import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:social_sense/controllers/login_controller.dart';
import 'package:social_sense/models/user_model.dart';
import 'package:social_sense/utils/api_endpoints.dart';
import 'package:social_sense/utils/styles/helper.dart';

class SearchUserController extends GetxController {
  var loading = false.obs;
  var notFound = false.obs;
  RxList<UserModel> user = <UserModel>[].obs;
  final loginController = Get.put(LoginController());

  Timer? _debounce;

  Future<void> searchUser(String? name) async {
    loading.value = true;
    notFound.value = false;
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      if (name != null && name.isNotEmpty) {
        if (name.isEmpty) {
          notFound.value = false;
          loading.value = false;
          user.clear();
          return;
        }
        loading.value = true;
        notFound.value = false;
        user.clear();
        try {
          final token = await loginController.getToken();

          var headers = {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          };
          var url = Uri.parse(
              '${ApiEndPoints.baseUrl}${ApiEndPoints.userEndpoints.search}?name=$name');

          var response = await http.get(
            url,
            headers: headers,
          );

          if (response.statusCode == 200) {
            List<dynamic> responseData = json.decode(response.body)['data'];
            if (responseData.isEmpty) {
              notFound.value = true;
            } else {
              var userList = responseData
                  .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
                  .toList();
              user.assignAll(userList);
              /*userList.forEach((u) {
                print(
                    'User: id=${u.id}, name=${u.name}, email=${u.email}, dob=${u.dob}, bio=${u.bio}, phone=${u.phone}');
              });*/
              print('User Length: ${user.length}');
              notFound.value = false;
            }
          } else {
            notFound.value = false;
            loading.value = false;
            print('Failed to fetch users. Status code: ${response.statusCode}');
          }
        } catch (e) {
          notFound.value = true;
          loading.value = false;
          print('Failed to fetch users. Error: $e');
          showErrorDialog(e.toString(), 'Error');
        }
      }
    });
  }
}
