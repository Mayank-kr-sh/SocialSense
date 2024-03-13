import 'package:flutter/material.dart';
import 'package:social_sense/utils/type_def.dart';

class AuthInput extends StatelessWidget {
  final String label;
  final String hintText;
  final bool isPassword;
  final TextEditingController controller;
  final ValidatorCallback validatorCallback;
  const AuthInput({
    super.key,
    required this.label,
    required this.hintText,
    this.isPassword = false,
    required this.controller,
    required this.validatorCallback,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPassword,
      controller: controller,
      validator: validatorCallback,
      decoration: InputDecoration(
        label: Text(label),
        hintText: hintText,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
