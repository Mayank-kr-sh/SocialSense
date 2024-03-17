import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:social_sense/controllers/thread_controller.dart';

class ThreadImagePrev extends StatelessWidget {
  ThreadImagePrev({super.key});
  final ThreadController threadController = Get.put(ThreadController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.file(
              threadController.images.value!,
              width: context.width * 0.8,
              height: context.height * 0.3,
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: GestureDetector(
              child: const CircleAvatar(
                backgroundColor: Colors.white38,
                child: Icon(Icons.close, color: Colors.black),
              ),
              onTap: () {
                threadController.images.value = null;
              },
            ),
          )
        ],
      ),
    );
  }
}
