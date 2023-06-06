import 'package:flutter/material.dart';

class TextboxWidget extends StatelessWidget {
  const TextboxWidget({
    super.key,
    required this.labelText,
    required this.controller,
    this.hintText,
    this.containerPadding,
    this.textboxPadding,
  });

  final String labelText;
  final TextEditingController controller;
  final String? hintText;
  final EdgeInsets? containerPadding;
  final EdgeInsets? textboxPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: containerPadding,
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      height: 45.0,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          contentPadding: textboxPadding,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 1.0,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 1.0,
            ),
          ),
        ),
        style: TextStyle(
          fontSize: 12,
        ),
      ),
    );
  }
}
