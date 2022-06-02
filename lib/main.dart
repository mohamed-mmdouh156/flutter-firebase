import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_firestore/Screens/LoginScreen/LoginScreen.dart';
import 'package:firebase_firestore/Screens/ProfileScreen/ProfileScreen.dart';
import 'package:firebase_firestore/Screens/RegisterScreen/RegisterScreen.dart';
import 'package:firebase_firestore/Screens/StartScreen/StartScreen.dart';
import 'package:flutter/material.dart';

import 'Screens/EditProfile/EditProfileScreen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter With Firebase',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          elevation: 0.0,
        ),
      ),
      home: const StartScreen(),
    );
  }
}

