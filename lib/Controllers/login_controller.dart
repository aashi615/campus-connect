// controllers/login_controller.dart
import 'package:campus_connect/Screens/Home_screen.dart';
import 'package:campus_connect/Screens/ViewMyProfile_Page.dart';  // Profile Page Import
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
class LoginController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> loginUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      // Sign in the user with email and password
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      // Check if the user's email is verified
      if (!userCredential.user!.emailVerified) {
        await userCredential.user!.sendEmailVerification();

        // Redirect user back to the login page with a message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Email is not verified. A verification link has been sent to your email.")),
        );

        // Sign out the user since their email isn't verified
        await _auth.signOut();
      } else {
        // Navigate to Home screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage(title: "My Home")),
        );

        // After moving to Home, check if the user's profile is complete
        Future.delayed(Duration.zero, () async {
          await _checkUserProfile(userCredential.user!.uid, context);
        });
      }
    } on FirebaseAuthException catch (e) {
      // Show an error message if login fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? "Login failed. Please try again.")),
      );
    }
  }

  Future<void> _checkUserProfile(String uid, BuildContext context) async {
    try {
      final userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (userDoc.exists) {
        final userData = userDoc.data()!;

        // Check if required profile fields are incomplete
        bool isProfileComplete = userData['chatIds']['name'] != '' &&
            userData['chatIds']['phoneNumber'] != '' &&
            userData['chatIds']['profileImgUrl'] != '';

        if (!isProfileComplete) {
          // Show a dialog asking the user to complete their profile
          if (context.mounted) {
            _showProfileDialog(context);
          }
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("User data not found. Please contact support.")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error checking profile. Please try again.")),
      );
    }
  }

  void _showProfileDialog(BuildContext context) {
    if (context.mounted) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Complete Your Profile"),
          content: Text("Your profile is incomplete. Please complete your profile to continue."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                // Redirect to profile completion page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>ProfilePage()),
                );
              },
              child: Text("Go to Profile"),
            ),
          ],
        ),
      );
    }
  }
}


class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Method for signing up the user
  Future<void> signUpUser(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Create a user structure in Firestore inside the 'chatIds' node
      if (userCredential.user != null) {
        await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
          'ads': {
            'branch': '',
          },
          'chatIds': {
            'course': '',
            'email': email,
            'name': '',
            'onlineStatus': true,
            'password': password,
            'phoneNumber': '',
            'phonecode': '',
            'profileImgUrl': '',
            'rollNo': '',
            'uid': userCredential.user!.uid,
            'userType': 'Email',
          }
        });
      }
    } on FirebaseAuthException catch (ex) {
      throw ex; // Handle the error or return the error message
    }
  }

}
