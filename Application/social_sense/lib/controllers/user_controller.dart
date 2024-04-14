import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:social_sense/models/auth_model.dart';
import 'package:social_sense/models/user_model.dart';

class UserController extends GetxController {
  final box = GetStorage();

  void setUser(AuthModel authModel) {
    print('User data received: ${authModel.user.toJson()}');
    box.write(
        'user',
        UserModel(
          id: authModel.user.id,
          name: authModel.user.name,
          email: authModel.user.email,
          bio: authModel.user.bio,
          dob: authModel.user.dob,
        ).toJson());
  }

  UserModel? get getUser {
    final user = box.read('user');
    if (user != null) {
      return UserModel.fromJson(user);
    }
    return null;
  }

  void updateUser(UserModel user) {
    box.write('user', user.toJson());
  }
}
