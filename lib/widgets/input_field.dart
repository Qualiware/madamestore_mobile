import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  InputField({
    Key? key,
    required this.icon,
    required this.hint,
    required this.obscure,
    required this.validator,
    required this.controller,
  }) : super(key: key);

  final IconData icon;
  final String hint;
  final bool obscure;
  final Function(String text) validator;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        icon: Icon(
          icon,
          color: Colors.white,
        ),
        hintText: hint,
        hintStyle: TextStyle(color: Colors.white),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.pinkAccent,
          ),
        ),
        contentPadding: EdgeInsets.only(
          left: 5,
          right: 30,
          bottom: 30,
          top: 30,
        ),
      ),
      style: TextStyle(color: Colors.white),
      obscureText: obscure,
      controller: controller,
      validator: validator(controller.text),
    );
  }
}
