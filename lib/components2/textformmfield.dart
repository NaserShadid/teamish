import 'package:flutter/material.dart';

class customFormField extends StatelessWidget {
  final String hinttext;
  final TextEditingController myController;
  final bool obsecuretext;
  final String? Function(String?)? validator;
  const customFormField(
      {super.key,
      required this.hinttext,
      required this.myController,
      this.obsecuretext = false,
      required this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: myController,
      obscureText: obsecuretext,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          fillColor: Colors.grey[100],
          filled: true,
          hintText: hinttext,
          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 18),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(70),
              borderSide: BorderSide(
                color: Color.fromARGB(255, 28, 44, 69),
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(70),
              borderSide: BorderSide(
                color: Color.fromARGB(255, 28, 44, 69),
              ))),
    );
  }
}
