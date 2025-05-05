import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_course/Auth2/Loginn.dart';
import 'package:flutter_course/Auth/login.dart';
import 'package:flutter_course/Auth2/Signupp.dart';
import 'package:flutter_course/Categories/add.dart';
import 'package:flutter_course/homepagee.dart';

import 'package:flutter_course/prac.dart/code.dart';
import 'package:flutter_course/prac.dart/filter.dart';
import 'package:flutter_course/prac.dart/homepage.dart';
import 'package:flutter_course/prac.dart/practice.dart';
import 'package:flutter_course/Auth/signup.dart';
import 'package:flutter_course/prac.dart/imagedisplay.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowMaterialGrid: false,
      theme: ThemeData(
          //scaffoldBackgroundColor: const Color.fromARGB(255, 70, 217, 75),
          fontFamily: "Jaro",
          appBarTheme: AppBarTheme(
              backgroundColor: Color.fromARGB(255, 28, 44, 69),
              centerTitle: true,
              elevation: 10.5),
          textTheme: const TextTheme(
            titleLarge: TextStyle(
                color: Color.fromARGB(255, 194, 254, 187),
                fontWeight: FontWeight.bold,
                fontSize: 20),
            bodyLarge: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color.fromARGB(255, 28, 44, 69)),
            bodyMedium: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
            bodySmall: TextStyle(
                color: Colors.purple,
                fontWeight: FontWeight.bold,
                fontSize: 14),
          )),
      debugShowCheckedModeBanner: false,
      home: (FirebaseAuth.instance.currentUser!= null &&
              FirebaseAuth.instance.currentUser!.emailVerified)
          ? Homepagee()
          : Loginn(),
      //testpage(),
      // const FilterFireStore(),
      // (FirebaseAuth.instance.currentUser != null &&
      //         FirebaseAuth.instance.currentUser!.emailVerified)
      //     ? const Homepage()
      //     : const Login(),
      routes: {
        // "signup": (context) => const SignUp(),
        "login": (context) => const Loginn(),
        "homepage": (context) => const Homepagee(),
        "signUp": (context) => const SignUpp(),
        // "addcategory": (context) => const AddCategory(),
        //"filterfirestore": (context) => FilterFireStore(),
        //"practice": (context) => practice(),
        //"loginn":(context)=> Loginn(),
      },
    );
  }
}
