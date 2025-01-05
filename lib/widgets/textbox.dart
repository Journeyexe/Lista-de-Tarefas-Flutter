import 'package:flutter/material.dart';

class Textbox extends StatelessWidget {
  final String placeholder;
  final TextEditingController controller;
  const Textbox({
    super.key,
    required this.placeholder,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[300],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        hintText: placeholder,
        hintStyle: TextStyle(
          color: Colors.black.withOpacity(.5)
        )
      ),
    );
  }
}
