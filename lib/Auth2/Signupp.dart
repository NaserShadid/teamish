import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/components2/customLogo.dart';
import 'package:flutter_course/components2/materialbutton.dart';
import 'package:flutter_course/components2/textformmfield.dart';

class SignUpp extends StatefulWidget {
  const SignUpp({super.key});

  @override
  State<SignUpp> createState() => _SignUppState();
}
GlobalKey <FormState> formState = GlobalKey<FormState>();
TextEditingController username = TextEditingController();
TextEditingController email = TextEditingController();
TextEditingController password = TextEditingController();

class _SignUppState extends State<SignUpp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sign Up Page",
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
                    "Sign Up",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    "Sign Up To Continue",
                    style: TextStyle(
                        color: Color.fromARGB(255, 101, 128, 172), fontSize: 18),
                  ),
              
                  Container(
                    height: 10,
                  ),
                  Text(
                    "Username",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
              
                  // **********Text Form field For username**********
                  //
                  //**********Text Form field For username**********
                  //
                  //**********Text Form field For username**********
              
                  customFormField(
                    hinttext: "Enter Your Username",
                    myController: username,
                    obsecuretext: false,
                     validator: (val) {
                        if(val==""){
                          return "Can't Be Empty";
                        }
                      },
                  ),
              // //
              
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
                        if(val==""){
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
                        if(val==""){
                          return "Can't Be Empty";
                        }
                      },
                  ),
                  // //
                ],
              ),
            ),

            // SignUp Button
            //
            //
            // Sign Up Button
            Container(
                child: buttonDesign(
                    onPressed: () async {
                      if (formState.currentState!.validate()){
                        try {
                        final credential = await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                          email: email.text,
                          password: password.text,
                        );
                        Navigator.of(context).pushReplacementNamed("login");
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.rightSlide,
                            title: 'Error',
                            desc: 'The password provided is too weak.',
                          )..show();
                          print('The password provided is too weak.');
                        } else if (e.code == 'email-already-in-use') {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.rightSlide,
                            title: 'Error',
                            desc: 'The account already exists for that email.',
                          )..show();
                          print('The account already exists for that email.');
                        }
                      } catch (e) {
                        print(e);
                      }
                      }
                    },
                    title: "Sign Up")),

            Container(
              height: 5,
            ),

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
                          color: Color.fromARGB(255, 28, 44, 69)),
                    ),
                    TextSpan(
                        text: "Log In!",
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
