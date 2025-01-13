import 'package:flutter/material.dart';

class Textbox extends StatelessWidget {
  final String placeholder;
  final TextEditingController controller;
  final bool description;
  const Textbox({
    super.key,
    required this.placeholder,
    required this.controller,
    this.description = false,
  });

  @override
  Widget build(BuildContext context) {
    late int maxLines;
    description ? maxLines = 10 : maxLines = 1;
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[300],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          hintText: placeholder,
          hintStyle: TextStyle(color: Colors.black.withOpacity(.5))),
    );
  }
}
