import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:campus_connect/Screens/Home_screen.dart';
import 'package:campus_connect/Screens/Ui_Helper.dart';
import 'package:campus_connect/Controllers/login_controller.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  AuthService _authService = AuthService(); // Create an instance of AuthService

  // SignUp method that calls the AuthService
  void signUp() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      UIHelper.CustomAlertBox(context, "Enter all the required fields");
    } else {
      try {
        await _authService.signUpUser(email, password);

      } on FirebaseAuthException catch (ex) {
        // Check if the user already exists
        if (ex.code == 'email-already-in-use') {
          UIHelper.CustomAlertBox(
              context, "This email is already registered. Please log in.");
        } else {
          UIHelper.CustomAlertBox(context, ex.message.toString());
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  SizedBox(height: 50),
                  Text(
                    "Sign up",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Create an account, it's free",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  SizedBox(height: 20),
                  inputFile(
                      controller: emailController,
                      label: "Email",
                      Icon: Icon(Icons.email)),
                  SizedBox(height: 20),
                  inputFile(
                      controller: passwordController,
                      label: "Password",
                      obscureText: true),
                ],
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.only(top: 3, left: 3),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border(
                      bottom: BorderSide(color: Colors.black),
                      top: BorderSide(color: Colors.black),
                      left: BorderSide(color: Colors.black),
                      right: BorderSide(color: Colors.black),
                    )),
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  onPressed: () {
                    signUp();
                  },
                  color: Color(0xff0095FF),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    "Sign up",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget for creating text input fields
Widget inputFile(
    {TextEditingController? controller,
      String? label,
      bool obscureText = false,
      Icon? Icon}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        label!,
        style: TextStyle(
            fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
      ),
      SizedBox(height: 5),
      TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          prefixIcon: Icon,
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          border: OutlineInputBorder(
            borderSide: BorderSide(),
          ),
        ),
      ),
      SizedBox(height: 10),
    ],
  );
}
