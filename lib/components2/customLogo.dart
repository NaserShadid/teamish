import 'package:flutter/material.dart';

class centerLogo extends StatelessWidget {
  const centerLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    shape: BoxShape.circle,
                  ),
                  padding: EdgeInsets.all(6),
                  child: ClipOval(
                      //borderRadius: BorderRadius.circular(70),
                      child: Image.asset(
                    "images/Imglogo.png",
                    fit: BoxFit.cover,
                  )),
                ),
              ),
            );
  }
}