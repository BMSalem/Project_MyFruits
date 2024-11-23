import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser!; 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Labs",
        style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Affichage de la photo de profil
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: user.photoURL != null
                        ? NetworkImage(user.photoURL!)
                        : AssetImage('images/avatar.jpg') as ImageProvider,
                    onBackgroundImageError: (_, __) => Icon(Icons.person, size: 80),
                  ),
                  SizedBox(height: 10),
                  // Affichage du nom de l'utilisateur ou de l'email
                  Text(
                    user.displayName ?? user.email!,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.coronavirus, color: Colors.redAccent),
              title: Text('Covid Tracker'),
              onTap: () {
                //openGoogleMaps();
              },
            ),
            ListTile(
              leading: Icon(Icons.search, color: Colors.green),
              title: Text('Fruits Classifier'),
              onTap: () {
                //navigateToFruitsClassifier();
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome, ${user.displayName ?? user.email!} !',
              style: GoogleFonts.robotoCondensed(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'This is your home screen.',
              style: GoogleFonts.robotoCondensed(fontSize: 18),
            ),
          ],
        ),  
      ),
    );
  }
}