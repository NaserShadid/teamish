import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  const CustomTextForm({super.key, required this.hintText, required this.myController,required this.validator});
final String? Function(String?)? validator;
  final String hintText;
  final TextEditingController myController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator:validator ,
      controller: myController,
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: const BorderSide(color: Colors.grey)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: const BorderSide(color: Colors.grey)),
                  ),
                );
  }
}