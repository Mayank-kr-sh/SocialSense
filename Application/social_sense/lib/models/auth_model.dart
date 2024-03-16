import 'dart:convert';

AuthModel authModelFromJson(String str) => AuthModel.fromJson(json.decode(str));

String authModelToJson(AuthModel data) => json.encode(data.toJson());

class AuthModel {
  User user;
  String token;

  AuthModel({
    required this.user,
    required this.token,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        user: User.fromJson(json["user"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "token": token,
      };
}

class User {
  String id;
  String name;
  String email;
  List<dynamic> posts;
  String? dob;
  String? bio;
  String? phone;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.posts = const [],
    this.dob,
    this.bio,
    this.phone,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"] ?? '',
        name: json["name"] ?? '',
        email: json["email"] ?? '',
        posts: json["posts"] != null
            ? List<dynamic>.from(json["posts"].map((x) => x))
            : [],
        dob: json["dob"] ?? '',
        bio: json["bio"] ?? '',
        phone: json["phone"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "posts": List<dynamic>.from(posts.map((x) => x)),
        "dob": dob,
        "bio": bio,
        "phone": phone,
      };
}
