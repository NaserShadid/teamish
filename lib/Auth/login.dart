import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/components/customButton.dart';
import 'package:flutter_course/components/customlogoauth.dart';
import 'package:flutter_course/components/textformfield.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLoading = false;
  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      return;
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);
    isLoading = true;
    setState(() {});
    Navigator.of(context).pushNamedAndRemoveUntil("homepage", (route) => false);
    isLoading = false;
    setState(() {});
  }

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
          "Log In Page",
          style: TextStyle(
              fontFamily: "jaro",
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 194, 254, 187)),
        ),
      ),
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
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
                        //const CustomlogoAuth(),
                        Container(
                          height: 20,
                        ),
                        const Text(
                          "Login",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Color.fromARGB(255, 28, 44, 69)),
                        ),
                        Container(
                          height: 5,
                        ),
                        const Text(
                          "Login to continue to use app",
                          style: TextStyle(
                              color:  Color.fromARGB(255, 101, 128, 172)),
                        ),
                        Container(
                          height: 10,
                        ),
                        const Text(
                          "Email",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color:  Color.fromARGB(255, 28, 44, 69)),
                        ),
                        Container(
                          height: 5,
                        ),
                        CustomTextForm(
                          hintText: "Enter your email",
                          myController: email,
                          validator: (val) {
                            if (val == "") {
                              return "Can't Be Empty";
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
                        TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: "Enter Your Password",
                            hintStyle: const TextStyle(
                                fontSize: 14, color: Colors.grey),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 2, horizontal: 10),
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide:
                                    const BorderSide(color: Colors.grey)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide:
                                    const BorderSide(color: Colors.grey)),
                          ),
                          validator: (val) {
                            if (val == "") {
                              return "Can't be Empty";
                            }
                            return null;
                          },
                        ),
                        Container(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () async {
                            if (email.text == "") {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.error,
                                animType: AnimType.rightSlide,
                                title: 'Alert',
                                desc:
                                    'Enter your email in your email field for password reset',
                                btnCancelOnPress: () {},
                                btnOkOnPress: () {},
                              ).show();
                              return;
                            }

                            try {
                              await FirebaseAuth.instance
                                  .sendPasswordResetEmail(email: email.text);

                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.info,
                                animType: AnimType.rightSlide,
                                title: 'Alert',
                                desc:
                                    'An Email has been sent to your email for password reset',
                                btnCancelOnPress: () {},
                                btnOkOnPress: () {},
                              ).show();
                            } catch (e) {
                              print(e);
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.error,
                                animType: AnimType.rightSlide,
                                title: 'Alert',
                                desc: 'Wrong Email Enterred',
                                btnCancelOnPress: () {},
                                btnOkOnPress: () {},
                              ).show();
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 10, bottom: 20),
                            alignment: Alignment.topRight,
                            child: const Text("Forgot Password?",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 80, 192, 67),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14)),
                          ),
                        )
                      ],
                    ),
                  ),

                  MaterialButton(
                    child: Text("Log in"),
                    textColor: Color.fromARGB(255, 194, 254, 187),
                    height: 40,
                    color: Color.fromARGB(255, 28, 44, 69),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () async {
                      if (formState.currentState!.validate()) {
                        try {
                          isLoading = true;
                          setState(() {});
                          final credential = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: email.text, password: password.text);
                          isLoading = false;
                          setState(() {});
                          if (credential.user!.emailVerified) {
                            Navigator.of(context)
                                .pushReplacementNamed("homepage");
                          } else {
                            FirebaseAuth.instance.currentUser!
                                .sendEmailVerification();
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.rightSlide,
                              title: 'Email Not Verified',
                              desc: 'Please Verify Your Email',
                              btnCancelOnPress: () {},
                              btnOkOnPress: () {},
                            ).show();
                          }
                        } on FirebaseAuthException catch (e) {
                          isLoading = false;
                          setState(() {});

                          if (e.code == 'user-not-found') {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.rightSlide,
                              title: 'Wrong  Email',
                              desc: 'No user found for that email.',
                            ).show();
                          } else if (e.code == 'wrong-password') {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.rightSlide,
                              title: 'Wrong Password',
                              desc: 'Wrong password provided for that user.',
                              btnCancelOnPress: () {},
                              btnOkOnPress: () {},
                            ).show();
                          }
                        }
                      } else {
                        print("Not Valid");
                      }
                    },
                  ),

                  // Custombutton(
                  //   title: "Login",
                  //   onPressed: () async {
                  //     if (formState.currentState!.validate()) {
                  //       try {
                  //         isLoading = true;
                  //         setState(() {});
                  //         final credential = await FirebaseAuth.instance
                  //             .signInWithEmailAndPassword(
                  //                 email: email.text, password: password.text);
                  //         isLoading = false;
                  //         setState(() {});
                  //         if (credential.user!.emailVerified) {
                  //           Navigator.of(context)
                  //               .pushReplacementNamed("homepage");
                  //         } else {
                  //           FirebaseAuth.instance.currentUser!
                  //               .sendEmailVerification();
                  //           AwesomeDialog(
                  //             context: context,
                  //             dialogType: DialogType.error,
                  //             animType: AnimType.rightSlide,
                  //             title: 'Email Not Verified',
                  //             desc: 'Please Verify Your Email',
                  //             btnCancelOnPress: () {},
                  //             btnOkOnPress: () {},
                  //           ).show();
                  //         }
                  //       } on FirebaseAuthException catch (e) {
                  //         isLoading = false;
                  //         setState(() {});

                  //         if (e.code == 'user-not-found') {
                  //           AwesomeDialog(
                  //             context: context,
                  //             dialogType: DialogType.error,
                  //             animType: AnimType.rightSlide,
                  //             title: 'Wrong  Email',
                  //             desc: 'No user found for that email.',
                  //           ).show();
                  //         } else if (e.code == 'wrong-password') {
                  //           AwesomeDialog(
                  //             context: context,
                  //             dialogType: DialogType.error,
                  //             animType: AnimType.rightSlide,
                  //             title: 'Wrong Password',
                  //             desc: 'Wrong password provided for that user.',
                  //             btnCancelOnPress: () {},
                  //             btnOkOnPress: () {},
                  //           ).show();
                  //         }
                  //       }
                  //     } else {
                  //       print("Not Valid");
                  //     }
                  //   },
                  // ),

                  Container(
                    height: 10,
                  ),
                 const Text(
                    "Or Login with google",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color:  Color.fromARGB(255, 28, 44, 69)),
                    textAlign: TextAlign.center,
                  ),

                  MaterialButton(
                      height: 40,
                      color: Color.fromARGB(255, 28, 44, 69),
                      textColor: Color.fromARGB(255, 194, 254, 187),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      onPressed: () {
                        signInWithGoogle();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Login With Google   ",
                          ),
                          Image.asset(
                            "images/img11g.png",
                            width: 20,
                          ),
                        ],
                      )),
                  // Text("Dont Have an account ? Register", textAlign: TextAlign.center,)
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed("SignUpp");
                    },
                    child: const Text.rich(
                        textAlign: TextAlign.center,
                        TextSpan(children: [
                          TextSpan(
                            text: "Dont have an account? ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color:  Color.fromARGB(255, 28, 44, 69)),
                          ),
                          TextSpan(
                              text: "Register?",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold)),
                        ])),
                  )
                ],
              ),
            ),
    );
  }
}
