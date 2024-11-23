import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

Future signUp() async{
    if(passwordConfirmed()){
      try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword
    (email: _emailController.text.trim(), password: _passwordController.text.trim());
    Navigator.of(context).pushNamed('/homeScreen');
      } catch(e){
        showErrorDialog('Sign Up Error', e.toString());
      }
    }else{
      showErrorDialog('Password Error', 'Passwords do not match !');
    }
}

bool passwordConfirmed(){
  if(_passwordController.text.trim()== _confirmPasswordController.text.trim()){
    return true;
  }else{
    return false;
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

void openLoginScreen(){
  Navigator.of(context).pushReplacementNamed('/signinScreen');
}

@override
void dispose(){ //Désactiver ces controllers ou cas on va plus les utiliser
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
}

  @override
  Widget build(BuildContext context){
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
                      Text('SIGN UP',
                      style: GoogleFonts.cabinCondensed(fontSize: 40,
                      fontWeight: FontWeight.bold),
                      ),
              
                      //Subtitle
                      Text('Welcome ! Here you can register :)',
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
                      SizedBox(height: 10),

                      //Confirm pwd
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: TextField(
                                controller: _confirmPasswordController,
                              obscureText: true,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Confirm Password',
                                    prefixIcon: Icon(Icons.key),
                                ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
              
                      //Signin buttn
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: GestureDetector(
                            onTap: signUp,
                          child: Container(
                            padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  color: Colors.red[900],
                                  borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(child: Text('Sign up',
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
                          Text('Already a member ?',
                          style: GoogleFonts.robotoCondensed(
                              fontWeight: FontWeight.bold,
                          ),),
                          GestureDetector(
                            onTap: openLoginScreen,
                            child: Text(' Sign in here ',
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
