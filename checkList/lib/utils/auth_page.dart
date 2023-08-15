
import 'package:checkList/screens/home.dart';
import 'package:checkList/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dcdg/dcdg.dart';
class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return HomeScreen();
          }else {
            return LoginScreen();
          }
        }
    )
    );
  }
}

class UserManagement {
  storeNewUser(user, context) {
  }
}
