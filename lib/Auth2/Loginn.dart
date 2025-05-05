import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/components2/customLogo.dart';
import 'package:flutter_course/components2/materialbutton.dart';
import 'package:flutter_course/components2/textformmfield.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Loginn extends StatefulWidget {
  const Loginn({super.key});

  @override
  State<Loginn> createState() => _LoginnState();
}

GlobalKey<FormState> formState = GlobalKey<FormState>();
TextEditingController email = TextEditingController();
TextEditingController password = TextEditingController();

Future signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  if(googleUser==null){
    return;
  }
  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  await FirebaseAuth.instance.signInWithCredential(credential);
  
 // Navigator.of(context).pushNamedAndRemoveUntil("homepage", (route) => false);
}

class _LoginnState extends State<Loginn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Log In Page",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        leading: Icon(Icons.account_circle_rounded,
            color: Color.fromARGB(255, 194, 254, 187)),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            //Logo Design
            centerLogo(),
//
            Form(
              key: formState,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Login",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    "Login To Continue to use app",
                    style: TextStyle(
                        color: Color.fromARGB(255, 101, 128, 172),
                        fontSize: 18),
                  ),
                  Container(
                    height: 10,
                  ),
                  Text(
                    "Email",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),

                  // **********Text Form field For Email**********
                  //
                  //**********Text Form field For Email**********
                  //
                  //**********Text Form field For Email**********

                  customFormField(
                    hinttext: "Enter Your Email",
                    myController: email,
                    obsecuretext: false,
                    validator: (val) {
                      if (val == "") {
                        return "Can't Be Empty";
                      }
                    },
                  ),
                  // //
                  Container(
                    height: 10,
                  ),
                  Text(
                    "Password",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  // **********Text Form field For Password**********
                  //
                  //**********Text Form field For Password**********
                  //
                  //**********Text Form field For Password**********

                  customFormField(
                    hinttext: "Enter Your Password",
                    myController: password,
                    obsecuretext: true,
                    validator: (val) {
                      if (val == "") {
                        return "Can't Be Empty";
                      }
                    },
                  ),
                  // //

                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    alignment: Alignment.topRight,
                    child: Text(
                      "Forgot Password? ",
                      style: TextStyle(
                          color: Color.fromARGB(255, 80, 192, 67),
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            //Custom Button
            ///
            ///
            ///
            ///

            buttonDesign(
                onPressed: () async {
                  if (formState.currentState!.validate()) {
                    try {
                      final credential = await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: email.text, password: password.text);
                      //if log in is succeful but email is not verified
                      //
                      //
                      if (credential.user!.emailVerified) {
                        Navigator.of(context).pushReplacementNamed("homepage");
                      } else {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          title: 'Error',
                          desc: 'Please Verify Your Email',
                        )..show();
                      }
                      // if log in is unsucceful display this.
                      //
                      //
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        print('No user found for that email.');
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          title: 'Wrong Email or Password',
                          desc: 'No user found for that email.',
                        )..show();
                      } else if (e.code == 'wrong-password') {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          title: 'Wrong Email or Password',
                          desc: 'Wrong password provided for that user.',
                        )..show();
                        print('Wrong password provided for that user.');
                      }
                    }
                  } else {
                    print("Error");
                  }
                },
                title: "Log In"),
            Container(
              height: 5,
            ),
            const Text(
              "Or Login with google",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color.fromARGB(255, 28, 44, 69)),
              textAlign: TextAlign.center,
            ),
            Container(
              height: 5,
            ),
            Container(
              child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(70)),
                  color: Color.fromARGB(255, 28, 44, 69),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Log in  ",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      ClipOval(
                        child: Image.asset(
                          "images/img11g.png",
                          width: 20,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {
                    signInWithGoogle();
                  }),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushReplacementNamed("signUp");
              },
              child: const Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(children: [
                    TextSpan(
                      text: "Dont have an account? ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Color.fromARGB(255, 28, 44, 69)),
                    ),
                    TextSpan(
                        text: "Register?",
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
