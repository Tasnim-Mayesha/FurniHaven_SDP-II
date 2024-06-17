import 'package:flutter/material.dart';

class GlobalTextForm extends StatelessWidget {
  const GlobalTextForm({super.key,
    required this.controller,
    required this.text,
    required this.textInputType,
    required this.obscure,
    required this.icon
  });
  final TextEditingController controller;
  final String text;
  final TextInputType textInputType;
  final bool obscure;
  final Icon icon;


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      padding: const EdgeInsets.only(top:3,left: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 7,
          )
        ]
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: textInputType,
        obscureText: obscure,
        decoration: InputDecoration(
          prefixIcon: icon,
          hintText: text,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 11),
          hintStyle: const TextStyle(
            height: 1
          ),
        ),
      ),
    );
  }
}
