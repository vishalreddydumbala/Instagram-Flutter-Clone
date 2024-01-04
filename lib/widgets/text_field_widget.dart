import 'package:flutter/material.dart';

@immutable
class TextFieldInput extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final TextInputType textType;
  final bool isPassword;
  TextFieldInput(
      {Key? key,
      required this.controller,
      required this.hint,
      required this.textType,
      required this.isPassword})
      : super(key: key);

  final _border = {
    'ok': OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.white),
    ),
    'error': OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Color.fromARGB(255, 165, 48, 39)),
    )
  };

  String? get hasError {
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          hintText: hint,
          border: _border['ok'],
          focusedBorder: _border['ok'],
          enabledBorder: _border['ok'],
          errorBorder: _border['error'],
          errorText: hasError,
          filled: true,
          fillColor: const Color.fromARGB(205, 49, 47, 47),
          contentPadding: const EdgeInsets.all(8)),
      keyboardType: textType,
      obscureText: isPassword,
      autocorrect: false,
      autofocus: false,
      style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          height: 1.5,
          fontWeight: FontWeight.bold),
    );
  }
}
