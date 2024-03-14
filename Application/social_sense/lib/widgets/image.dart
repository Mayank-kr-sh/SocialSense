import 'dart:io';

import 'package:flutter/material.dart';

class CircleImage extends StatelessWidget {
  final double radius;
  final String? imageUrl;
  final File? file;
  const CircleImage({super.key, this.radius = 20, this.imageUrl, this.file});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (imageUrl != null)
          CircleAvatar(
            radius: radius,
            backgroundImage: NetworkImage(imageUrl!),
          )
        else if (file != null)
          CircleAvatar(
            radius: radius,
            backgroundImage: FileImage(file!),
          )
        else
          CircleAvatar(
            radius: radius,
            backgroundImage: const AssetImage('assets/images/avatar.png'),
          ),
      ],
    );
  }
}
