import 'package:flutter/material.dart';
import 'dart:async';
import 'intro_screen.dart'; // Import for using Timer

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Schedule a timer to navigate after 3 seconds
    Timer(const Duration(seconds: 3), () {
      // Navigate to the Intro screen after 3 seconds
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const IntroScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Displaying the image with improved size and fit
            ClipRRect(
              borderRadius: BorderRadius.circular(16.0), // Rounded corners for the image
              child: Image.asset(
                'assets/splash.jpg',
                width: MediaQuery.of(context).size.width * 0.85,
                height: MediaQuery.of(context).size.height * 0.4,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 40),

            // Displaying the main text with improved style
            const Text(
              'Make Your Farming Experience Enhanced with',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Colors.black87,
                fontFamily: 'Poppins', // Add your desired font here
              ),
            ),

            // Displaying the highlighted text "AgriFarma"
            const Text(
              'AgriFarma',
              style: TextStyle(
                fontSize: 28,
                color: Color(0xFF56ab2f),
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins', // Add your desired font here
              ),
            ),

            const SizedBox(height: 30),

            // Adding the circular progress indicator with a better appearance
            const CircularProgressIndicator(
              color: Color(0xFF56ab2f),
              strokeWidth: 4,
              backgroundColor: Colors.grey, // Background color for contrast
            ),
          ],
        ),
      ),
    );
  }
}
