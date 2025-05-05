import 'package:flutter/material.dart';

class Custombutton extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  const Custombutton({super.key, required this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
                height: 40,
                color: Colors.grey[700],
                textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                      ),
                  onPressed: onPressed,
                  child: Text(title),
                  );
  }
}

class CustombuttonUpload extends StatelessWidget {
  final String title;
  final bool isSelected;
  final void Function()? onPressed;
  const CustombuttonUpload({super.key, required this.title, this.onPressed, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
                height: 40,
                color: Colors.grey[700],
                textColor: isSelected? Colors.white: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                      ),
                  onPressed: onPressed,
                  child: Text(title),
                  );
  }
}