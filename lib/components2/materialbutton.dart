import 'package:flutter/material.dart';

class buttonDesign extends StatelessWidget {
  final  void Function() onPressed;
  final String title;
  const buttonDesign({super.key, required this.onPressed, required this.title});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(70)),
                  color: Color.fromARGB(255, 28, 44, 69),
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  onPressed: onPressed,
    );
  }
}