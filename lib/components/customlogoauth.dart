import 'package:flutter/material.dart';

class CustomlogoAuth extends StatelessWidget {
  const CustomlogoAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
                  child: Container(
                    alignment: Alignment.center,
                    width: 70,
                    height: 70,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(70)),
                    child: Image.asset(
                      "images/imglogo.png",
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
  }
}