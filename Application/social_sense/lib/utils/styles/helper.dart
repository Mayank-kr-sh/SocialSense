import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

void showErrorDialog(String message, String title) {
  Get.back();
  showDialog(
    barrierColor: const Color.fromARGB(255, 30, 30, 30).withOpacity(0.7),
    context: Get.context!,
    builder: (context) => AlertDialog(
      title: Text(title),
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

Future<File?> pickImageFromGallery() async {
  const uuid = Uuid();
  final ImagePicker picker = ImagePicker();
  final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  if (image == null) return null;
  final dir = Directory.systemTemp;
  final target = '${dir.absolute.path}/${uuid.v6()}.jpg';
  return compressImage(File(image.path), target);
}

// compress image file

Future<File?> compressImage(File file, String target) async {
  var result = await FlutterImageCompress.compressAndGetFile(
    file.absolute.path,
    target,
    quality: 70,
  );
  return File(result!.path);
}
