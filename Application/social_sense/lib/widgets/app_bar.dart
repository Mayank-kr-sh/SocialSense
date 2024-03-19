import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_sense/controllers/thread_controller.dart';

class AddThreadAppBar extends StatelessWidget {
  AddThreadAppBar({super.key});

  final ThreadController threadController = Get.find<ThreadController>();

  void onSubmit() {
    threadController.uploadPost();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xff242424),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  // Navigator.pop(context);
                },
                icon: const Icon(Icons.close),
              ),
              const SizedBox(width: 10),
              const Text(
                'New Thread',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          Obx(
            () => TextButton(
                onPressed: onSubmit,
                child: threadController.loading.value
                    ? const SizedBox(
                        height: 14,
                        width: 14,
                        child: CircularProgressIndicator(),
                      )
                    : const Text('Post')),
          )
        ],
      ),
    );
  }
}
