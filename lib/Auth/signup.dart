import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/components/customButton.dart';
import 'package:flutter_course/components/customlogoauth.dart';
import 'package:flutter_course/components/textformfield.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 28, 44, 69),
        leading: Icon(
          Icons.account_box_rounded,
          color: Color.fromARGB(255, 194, 254, 187),
        ),
        centerTitle: true,
        title: const Text(
          "Sign Up Page",
          style: TextStyle(
              fontFamily: "jaro",
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 194, 254, 187)),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Form(
              key: formState,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 50,
                  ),
                  Center(
                    child: Container(
                      alignment: Alignment.center,
                      width: 100,
                      height: 100,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(70),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(70),
                        child: Image.asset(
                          "images/Imglogo.png",
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 20,
                  ),
                  const Text(
                    "SignUp",
                    style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Color.fromARGB(255, 28, 44, 69)),
                  ),
                  Container(
                    height: 5,
                  ),
                 const Text(
                    "SignUp to continue to use app",
                    style: TextStyle(
                        color:  Color.fromARGB(255, 101, 128, 172)),
                  ),
                  Container(
                    height: 10,
                  ),
                 const Text(
                    "username",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color:  Color.fromARGB(255, 28, 44, 69)),
                  ),
                  Container(
                    height: 5,
                  ),
                  CustomTextForm(
                    hintText: "Enter your username",
                    myController: username,
                    validator: (val) {
                      if (val == "") {
                        return "Can't be Empty";
                      }
                      return null;
                    },
                  ),
                  Container(
                    height: 5,
                  ),
                  Container(
                    height: 10,
                  ),
                 const Text(
                    "Email",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color.fromARGB(255, 28, 44, 69)),
                  ),
                  Container(
                    height: 5,
                  ),
                  CustomTextForm(
                    hintText: "Enter your email",
                    myController: email,
                    validator: (val) {
                      if (val == "") {
                        return "Can't be Empty";
                      }
                      return null;
                    },
                  ),
                  Container(
                    height: 5,
                  ),
                 const Text(
                    "Password",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color:  Color.fromARGB(255, 28, 44, 69)),
                  ),
                  Container(
                    height: 5,
                  ),
                  CustomTextForm(
                    hintText: "Enter your password",
                    myController: password,
                    validator: (val) {
                      if (val == "") {
                        return "Can't be Empty";
                      }
                      return null;
                    },
                  ),
                  Container(
                    height: 5,
                  ),
                  // Text(
                  //   "Confirm Password",
                  //   style: Theme.of(context).textTheme.bodyLarge,
                  // ),
                  Container(
                    height: 5,
                  ),
                  // CustomTextForm(
                  //     hintText: "Confirm your password", myController: password),
                  Container(
                    height: 10,
                  ),
                ],
              ),
            ),

            MaterialButton(
              child: Text("Sign Up"),
              textColor: Color.fromARGB(255, 194, 254, 187),
              height: 40,
              color: Color.fromARGB(255, 28, 44, 69),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              onPressed: () async {
                if (formState.currentState!.validate()) {
                  try {
                    final credential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                      email: email.text,
                      password: password.text,
                    );
                    FirebaseAuth.instance.currentUser!.sendEmailVerification();
                    Navigator.of(context).pushReplacementNamed("login");
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      print('The password provided is too weak.');
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.rightSlide,
                        title: 'Wrong a',
                        desc: 'The password provided is too weak.',
                        btnCancelOnPress: () {},
                        btnOkOnPress: () {},
                      ).show();
                    } else if (e.code == 'email-already-in-use') {
                      print('The account already exists for that email.');
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.rightSlide,
                        title: 'Wrong',
                        desc: 'The account already exists for that email.',
                        btnCancelOnPress: () {},
                        btnOkOnPress: () {},
                      ).show();
                    }
                  } catch (e) {
                    print(e);
                  }
                } else {
                  print("Not Valid");
                }
              },
            ),

            // Custombutton(
            //   title: "Sign Up",
            //   onPressed: () async {
            //     if (formState.currentState!.validate()) {
            //       try {
            //         final credential = await FirebaseAuth.instance
            //             .createUserWithEmailAndPassword(
            //           email: email.text,
            //           password: password.text,
            //         );
            //         FirebaseAuth.instance.currentUser!.sendEmailVerification();
            //         Navigator.of(context).pushReplacementNamed("login");
            //       } on FirebaseAuthException catch (e) {
            //         if (e.code == 'weak-password') {
            //           print('The password provided is too weak.');
            //           AwesomeDialog(
            //             context: context,
            //             dialogType: DialogType.error,
            //             animType: AnimType.rightSlide,
            //             title: 'Wrong a',
            //             desc: 'The password provided is too weak.',
            //             btnCancelOnPress: () {},
            //             btnOkOnPress: () {},
            //           ).show();
            //         } else if (e.code == 'email-already-in-use') {
            //           print('The account already exists for that email.');
            //           AwesomeDialog(
            //             context: context,
            //             dialogType: DialogType.error,
            //             animType: AnimType.rightSlide,
            //             title: 'Wrong',
            //             desc: 'The account already exists for that email.',
            //             btnCancelOnPress: () {},
            //             btnOkOnPress: () {},
            //           ).show();
            //         }
            //       } catch (e) {
            //         print(e);
            //       }
            //     } else {
            //       print("Not Valid");
            //     }
            //   },
            // ),
            Container(
              height: 10,
            ),

            // Text("Dont Have an account ? Register", textAlign: TextAlign.center,)
            InkWell(
              onTap: () {
                Navigator.of(context).pushReplacementNamed("login");
              },
              child: const Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(children: [
                    TextSpan(
                      text: "Already have an account? ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color:  Color.fromARGB(255, 28, 44, 69)),
                    ),
                    TextSpan(
                        text: "Login?",
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold)),
                  ])),
            )
          ],
        ),
      ),
    );
  }
}
