import 'package:flutter/material.dart';
import 'package:social_sense/models/user_model.dart';
import 'package:social_sense/widgets/image.dart';

class UserTile extends StatelessWidget {
  final UserModel user;
  const UserTile({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    //print('UserTile: $user');
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: ListTile(
          leading: const Padding(
            padding: EdgeInsets.all(7.0),
            child: CircleImage(
              radius: 20,
            ),
          ),
          title: Text(user.name ?? 'No Name'),
          subtitle: Text(user.bio ?? 'Not Specified'),
        ),
      ),
    );
  }
}
