import 'package:checkList/screens/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/reuseable_widget.dart';
import 'home.dart';
import '../utils/colors.dart';
import 'package:dcdg/dcdg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
                                                    
  @override
  State<LoginScreen> createState() => _LoginScreenState();

}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextFieldFactory factory = ReusableTextFieldFactory();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            hexStringToColor("FF84BA"),
            hexStringToColor("B267EE")
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 80, 20, 0),
          child: Column(
            children: <Widget>[
              const Text("Save your tasks", style: TextStyle(
                color: Colors.white,
                fontSize: 34,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic
              )),
              const Padding(
                padding: EdgeInsets.only(left: 150), // Sets padding on all sides
                child: Text(
                  "To Do List",
                  style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    fontStyle: FontStyle.italic
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Image.asset("asset/in-love.png",
                  fit: BoxFit.fitWidth,
                width: 300,
                height: 325),
              const SizedBox(
                height: 25,
              ),
              factory.createTextField("Enter Email Address", Icons.person, false, _emailTextController),
              // reusableTextField("Enter Email Address", Icons.person,
              //     false, _emailTextController),
              const SizedBox(
                height: 15,
              ),
              factory.createTextField("Enter Password", Icons.lock, true, _passwordTextController),
              // reusableTextField("Enter Password", Icons.lock, true, _passwordTextController),
              const SizedBox(
                height: 5,
              ),
              signInSignUpButton(context, true, () async {
                try {
                  UserCredential userCredential = await FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                      email: _emailTextController.text,
                      password: _passwordTextController.text);

                  print("Login successful");
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => HomeScreen()));
                } on FirebaseAuthException catch (e) {
                  String errorMessage = "Invalid email address or password!";
                  if(e.code == 'user-not-found') {
                    errorMessage = "User not found! Please check your email address.";
                  } else if (e.code == 'wrong-password') {
                    errorMessage = "Incorrect password! Please try again.";
                  }
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Login Error", style: TextStyle(color: Colors.purple)),
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


              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account ? ",
                      style: TextStyle(color: Colors.white70)),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SignUpScreen()));
                    },
                    child: const Text(
                      " Register",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),

              SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    ),);
  }

}
