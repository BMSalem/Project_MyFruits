import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fruits_classifier/screens/home_screen.dart';
import 'package:fruits_classifier/screens/onBoarding_screen.dart';
import 'package:fruits_classifier/screens/signin_screen.dart';
import 'package:fruits_classifier/screens/signup_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fruit Classification',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => OnboardingScreen(),
        '/signinScreen': (context) => SignInScreen(),
        '/signupScreen': (context) => SignUpScreen(),
        '/homeScreen': (context) => HomeScreen(),
      },
    );
  }
}