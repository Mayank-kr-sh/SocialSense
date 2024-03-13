import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:social_sense/controllers/registration_controller.dart';
import 'package:social_sense/routes/route_names.dart';
import 'package:social_sense/widgets/auth_input.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void submit() {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text;
      String email = _emailController.text;
      String password = _passwordController.text;
      // print('All Thing Work Fine');
      RegistrationController().registerUser(name, email, password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(10),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    width: 60,
                    height: 60,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Register',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('Welcome To SocialScence'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  AuthInput(
                    controller: _nameController,
                    label: 'Name',
                    hintText: 'Enter Your Name',
                    validatorCallback: ValidationBuilder()
                        .required()
                        .minLength(3)
                        .maxLength(50)
                        .build(),
                  ),
                  const SizedBox(height: 20),
                  AuthInput(
                    controller: _emailController,
                    label: 'E-mail',
                    hintText: 'Enter Your E-mail',
                    validatorCallback:
                        ValidationBuilder().required().email().build(),
                  ),
                  const SizedBox(height: 20),
                  AuthInput(
                    controller: _passwordController,
                    label: 'Password',
                    hintText: 'Enter Your Password',
                    isPassword: true,
                    validatorCallback: ValidationBuilder()
                        .required()
                        .minLength(6)
                        .maxLength(50)
                        .build(),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 30,
                        ),
                      ),
                      minimumSize: MaterialStateProperty.all(
                        const Size(double.infinity, 0),
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    onPressed: submit,
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text.rich(
                    TextSpan(
                      text: 'Already have an account ? ',
                      children: [
                        TextSpan(
                          text: ' Log In',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.toNamed(RouteNames.login);
                            },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
