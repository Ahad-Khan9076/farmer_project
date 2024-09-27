import 'package:farmer_project/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    // Timer to change image every 1.5 seconds
    _timer = Timer.periodic(const Duration(milliseconds: 1500), (Timer timer) {
      if (_currentPage < 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _navigateToHomePage(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF56ab2f), Color(0xFFa8e063)], // Green gradient
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // PageView for scrollable and auto-changing images
            SizedBox(
              height: 300,
              child: PageView(
                controller: _pageController,
                children: [
                  Image.asset('assets/Home.jpg', fit: BoxFit.cover),
                  Image.asset('assets/crop.jpg', fit: BoxFit.cover),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Beautifully styled introductory text
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.0),
              child: Text(
                'Welcome to AgriFarma!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.0,
                  height: 1.5,
                  shadows: [
                    Shadow(
                      blurRadius: 4.0,
                      color: Colors.black26,
                      offset: Offset(2.0, 2.0),
                    ),
                  ],
                ),
              ),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
              child: Text(
                'Optimize your farming practices with data-driven insights and recommendations.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white70,
                  letterSpacing: 0.5,
                  height: 1.5,
                ),
              ),
            ),

            const SizedBox(height: 40),

            // Beautifully styled "Continue" button
            ElevatedButton(
              onPressed: () => _navigateToHomePage(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFffffff),
                foregroundColor: const Color(0xFF56ab2f),
                padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                shadowColor: Colors.black.withOpacity(0.3),
                elevation: 8,
              ),
              child: const Text(
                'Continue',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
