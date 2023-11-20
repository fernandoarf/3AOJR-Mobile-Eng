import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final TextEditingController controller;
  final String placeholder;
  final bool obscureText;
  const TextInput(
      {super.key,
      required this.controller,
      required this.placeholder,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade300)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade300)),
            fillColor: Colors.grey.shade200,
            filled: true,
            hintText: placeholder,
            hintStyle: TextStyle(color: Colors.grey[600])));
  }
}
