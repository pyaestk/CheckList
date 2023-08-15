import 'package:checkList/screens/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../widgets/reuseable_widget.dart';
import 'package:dcdg/dcdg.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();
  TextFieldFactory factory = ReusableTextFieldFactory();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              hexStringToColor("B267EE"),
              hexStringToColor("FF84BA"),
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 130, 20, 0),
            child: Column(
              children: <Widget>[
                const Text("Register Now", style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic
                )),
                const Padding(
                  padding: EdgeInsets.only(left: 150), // Sets padding on all sides
                  child: Text(
                    "to do list app",
                    style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        fontStyle: FontStyle.italic
                    ),
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                factory.createTextField("Enter UserName", Icons.person_outline, false,
                    _userNameTextController),
                // reusableTextField("Enter UserName", Icons.person_outline, false,
                //     _userNameTextController),
                const SizedBox(
                  height: 15,
                ),
                factory.createTextField("Enter Email address", Icons.person_outline, false,
                    _emailTextController),
                // reusableTextField("Enter Email address", Icons.person_outline, false,
                //     _emailTextController),
                const SizedBox(
                  height: 15,
                ),
                factory.createTextField("Enter Password", Icons.lock_outlined, true,
                    _passwordTextController),
                // reusableTextField("Enter Password", Icons.lock_outlined, true,
                //     _passwordTextController),
                const SizedBox(
                  height: 10,
                ),

                //signup firebase
                signInSignUpButton(context, false, () async {
                  try {
                    //creating user
                     UserCredential usercredit = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                        email: _emailTextController.text,
                        password: _passwordTextController.text);

                     FirebaseFirestore.instance.collection("Users")
                     .doc(usercredit.user!.email)
                     .set({
                       'userName' : _userNameTextController.text,
                       'userEmail': _emailTextController.text
                     });

                     Navigator.push(context,
                         MaterialPageRoute(builder: (context) => HomeScreen()));
                     
                  } on FirebaseAuthException catch(e) {
                    String errorMessage = e.code;
                    if(e.code == 'unknown') {
                      errorMessage = "Invalid email address or password!";
                    }
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Try Again!", style: TextStyle(color: Colors.purple)),
                          content: Text(errorMessage,style: TextStyle(color: Colors.black54)),
                          actions: <Widget>[
                            TextButton(
                              child: Text('OK',style: TextStyle(color: Colors.purple, fontSize: 15)),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                }),

                SizedBox(
                  height: 30,
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
