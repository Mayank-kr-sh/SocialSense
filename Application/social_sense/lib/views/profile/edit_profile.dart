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
  final TextEditingController _nameController = TextEditingController(text: '');
  final TextEditingController _numberController =
      TextEditingController(text: '');
  final TextEditingController _dateController = TextEditingController(text: '');

  // @override
  // void initState() {
  //   _descriptionController.text = controller.authModel.value.data!.description;
  //   _nameController.text = controller.authModel.value.data!.name;
  //   _numberController.text = controller.authModel.value.data!.number;
  //   _dateController.text = controller.authModel.value.data!.dob;
  //   super.initState();
  // }

  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        _dateController.text =
            '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}';
      });
    }
  }

  void onSubmit() {
    ProfileController().updateUser(_descriptionController.text,
        _nameController.text, _numberController.text, _dateController.text);
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _dateController.dispose();
    _nameController.dispose();
    _numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: onSubmit,
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
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                hintText: 'About Discription',
                label: Text('Discription'),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                hintText: 'Your Name',
                label: Text('Name'),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _numberController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                hintText: 'Enter Your Number',
                label: Text('Phone Number'),
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                _selectDate(context);
              },
              child: IgnorePointer(
                child: TextFormField(
                  controller: _dateController,
                  readOnly: true,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    labelText: 'DD/MM/YYYY',
                    hintText: _selectedDate != null
                        ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                        : 'Select Date of Birth',
                    suffixIcon: const Icon(Icons.calendar_today),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
