import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_sense/controllers/thread_controller.dart';
import 'package:social_sense/controllers/user_controller.dart';
import 'package:social_sense/widgets/app_bar.dart';
import 'package:social_sense/widgets/image.dart';
import 'package:social_sense/widgets/thread_image_prev.dart';

class ThreadScreen extends StatefulWidget {
  ThreadScreen({super.key});

  @override
  State<ThreadScreen> createState() => _ThreadScreenState();
}

class _ThreadScreenState extends State<ThreadScreen> {
  final UserController userController = Get.put(UserController());

  final ThreadController threadController = Get.put(ThreadController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AddThreadAppBar(),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 10),
                  const CircleImage(),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: context.width * 0.8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userController.getUser?.name ?? 'User Name',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          '2 hours ago',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        TextField(
                          controller: threadController.contentController,
                          onChanged: (value) {
                            threadController.content.value = value;
                          },
                          style: const TextStyle(fontSize: 14),
                          maxLines: 10,
                          minLines: 1,
                          maxLength: 1000,
                          decoration: const InputDecoration(
                            hintText: 'What\'s happening?',
                            border: InputBorder.none,
                          ),
                        ),
                        GestureDetector(
                          child: const Icon(Icons.attach_file_rounded,
                              color: Colors.grey),
                          onTap: () {
                            threadController.pickImage();
                          },
                        ),
                        Obx(() => Column(
                              children: [
                                if (threadController.images.value != null)
                                  ThreadImagePrev(),
                              ],
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
