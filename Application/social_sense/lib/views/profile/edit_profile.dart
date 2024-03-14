import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_sense/controllers/profile_controller.dart';
import 'package:social_sense/widgets/image.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  // we use find bec it instance it already created in profile screen and we can use it here also
  final ProfileController controller = Get.find<ProfileController>();
  final TextEditingController _descriptionController =
      TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'Done',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Obx(() => Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleImage(
                      radius: 80,
                      file: controller.image.value,
                    ),
                    IconButton(
                      onPressed: () {
                        controller.pickImage();
                      },
                      icon: const CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white60,
                        child: Icon(Icons.edit),
                      ),
                    ),
                  ],
                )),
            const SizedBox(height: 20),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: 'Your Discription',
                  label: Text('Discription')),
            ),
          ],
        ),
      ),
    );
  }
}
