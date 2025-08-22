import 'dart:async';
import 'package:campus_connect/Screens/Home_screen.dart';
import 'package:campus_connect/Screens/Welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Start the timer for splash duration
    Timer(const Duration(seconds: 5), _checkUserStatus);
  }

  void _checkUserStatus() async {
    User? user = FirebaseAuth.instance.currentUser; // Check if user is logged in

    if (user != null) {
      // If user is logged in, navigate to HomeScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage(title: "My Home")),
      );
    } else {
      // If user is not logged in, navigate to WelcomeScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WelcomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFA9E0F9), // Light blue background
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/Logo.png',
              height: 200,
              width: 200,
            ),
            const SizedBox(height: 130),
            Text(
              'CAMPUS CONNECT',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF024472), // Adjust text color as needed
              ),
            ),
          ],
        ),
      ),
    );
  }
}
