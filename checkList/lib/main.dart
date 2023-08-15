
import 'package:checkList/todologic/todosprovider.dart';
import 'package:checkList/utils/auth_page.dart';
import 'package:checkList/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/login.dart';
import 'package:dcdg/dcdg.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context)=> TodosProvider(),
    child: MaterialApp(
      title: 'Flutter to do list app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AuthPage(),
    ));
  }
}
