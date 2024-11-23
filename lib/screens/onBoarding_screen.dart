import 'package:flutter/material.dart';
import 'package:slide_to_act/slide_to_act.dart';

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          OnboardingPage(
            image: 'assets/images/basketfruits.jpg',
            title: 'Identify Fruits Instantly',
            description: 'Snap a photo and get instant fruit classification.',
          ),
          OnboardingPage(
            image: 'assets/images/basketfruits.jpg',
            title: 'Track Your Favorites',
            description: 'Save fruits to your favorites for easy access.',
          ),
          OnboardingPage(
            image: 'assets/images/basketfruits.jpg',
            title: 'Learn About Fruits',
            description: 'Get detailed information about each fruit.',
            showSlideToAct: true, // Enable sliding action on the last page
          ),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final bool showSlideToAct;

  OnboardingPage({
    required this.image,
    required this.title,
    required this.description,
    this.showSlideToAct = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image, height: 250),
          SizedBox(height: 20),
          Text(
            title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            description,
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          Spacer(),
          if (showSlideToAct)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SlideAction(
                text: "Get Started",
                textStyle: TextStyle(fontSize: 18, color: Colors.white),
                onSubmit: () {
                  Navigator.pushNamed(context, '/signinScreen'); // Navigate to Sign-In
                },
                sliderButtonIcon: Icon(Icons.arrow_forward, color: Colors.white),
                outerColor: Colors.green,
                innerColor: Colors.white,
              ),
            ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
