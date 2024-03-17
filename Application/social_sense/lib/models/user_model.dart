class UserModel {
  final String id;
  final String? name;
  final String? email;
  final String? dob;
  final String? bio;
  final String? phone;

  UserModel({
    required this.id,
    this.name,
    this.email,
    this.dob,
    this.bio,
    this.phone,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      dob: json['dob'],
      bio: json['bio'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'dob': dob,
      'bio': bio,
      'phone': phone,
    };
  }
}

// class UserModel {
//   static String id = '';
//   static String name = '';
//   static String email = '';
//   static String? dob;
//   static String? bio;
//   static String? phone;
// }
