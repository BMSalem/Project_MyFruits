import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
final _emailController = TextEditingController();
final _passwordController = TextEditingController();

Future signIn() async{
  final email = _emailController.text.trim();
  final password = _passwordController.text.trim();
    if (email.isEmpty || password.isEmpty) {
    // Show an error message if the email or password is empty
    showErrorDialog('Error', 'Please enter a valid email and password');
    return;
  }

  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    // Sign-in successful, navigate to the next screen
    Navigator.of(context).pushNamed('/homeScreen');
  } catch (e) {
    // Show an error message if the sign-in fails
    showErrorDialog('Error', e.toString());
  }
}
void showErrorDialog(String title, String message) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}

void openSignupScreen(){
  Navigator.of(context).pushReplacementNamed('/signupScreen');
}

@override
void dispose(){ //Désactiver ces controllers ou cas on va plus les utiliser pour vider la mémoire
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView( //Pour que les textview n'affiche pas erreur
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                      //Image
                      Image.asset('assets/images/basketfruits.jpg',height: 250,),
                      const SizedBox(height: 20),
                      //Title
                      Text('SIGN IN',
                      style: GoogleFonts.cabinCondensed(fontSize: 40,
                      fontWeight: FontWeight.bold),
                      ),
              
                      //Subtitle
                      Text('Welcome to MyFruits !',
                      style: GoogleFonts.robotoCondensed(fontSize: 18),
                      ),
                      SizedBox(
                          height: 50,
                      ),
              
                      //Email Textfield
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: TextField(
                                controller: _emailController, //Enregistre l'email dans ce controller
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Email',
                                    prefixIcon: Icon(Icons.email),
                                ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
              
                      //pwd Textfield
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: TextField(
                                controller: _passwordController,
                              obscureText: true,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Password',
                                    prefixIcon: Icon(Icons.lock),
                                ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
              
                      //Signin buttn
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: ElevatedButton(
                            onPressed: signIn,
                          child: Container(
                            padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  color: Colors.red[900],
                                  borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(child: Text('Sign in',
                              style: GoogleFonts.robotoCondensed(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18
                              ),)),
                          ),
                        ),
                      ),
                      SizedBox(height: 25),
              
                      //text signup
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Need an account ?',
                          style: GoogleFonts.robotoCondensed(
                              fontWeight: FontWeight.bold,
                          ),),
                          GestureDetector(
                            onTap: openSignupScreen,
                            child: Text(' Sign up here ',
                            style: GoogleFonts.robotoCondensed(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold,
                            ),),
                          )
                        ],
                      )
                  ],
              ),
            ),
          ),
        ),
    );
  }
}