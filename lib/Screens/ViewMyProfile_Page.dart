import 'package:campus_connect/Screens/Home_screen.dart';
import 'package:campus_connect/Screens/EditProfile_screen.dart';
import 'package:campus_connect/Screens/Login_screen.dart'; // Import your login screen
import 'package:campus_connect/Screens/Welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:campus_connect/Screens/Marketplace_screen.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? user = FirebaseAuth.instance.currentUser;
  Map<String, dynamic>? userData;
  int _currentIndex = 3; // Initialize _currentIndex to the profile tab index

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    if (user != null) {
      try {
        final DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .get();

        setState(() {
          userData = userDoc.data() as Map<String, dynamic>?;
        });
      } catch (e) {
        print('Error fetching user data: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Color(0xff0095FF),
        title: Text(
          'Profile',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: userData == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: (userData?['chatIds']?['profileImgUrl'] ?? '').isNotEmpty
                  ? NetworkImage(userData!['chatIds']['profileImgUrl'])
                  : null,
              child: (userData?['chatIds']?['profileImgUrl'] ?? '').isEmpty
                  ? Icon(Icons.person, size: 50)
                  : null,
            ),
            SizedBox(height: 16),
            Text(
              userData?['chatIds']?['name'] ?? 'No Name',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            _buildInfoRow("Email", userData?['chatIds']?['email']),
            SizedBox(height: 6),
            _buildInfoRow("Phone", userData?['chatIds']?['phoneNumber']),
            SizedBox(height: 6),
            _buildInfoRow("Roll No.", userData?['chatIds']?['rollNo']),
            SizedBox(height: 6),
            _buildInfoRow("Course", userData?['chatIds']?['course']),
            SizedBox(height: 6),
            _buildInfoRow("Branch", userData?['ads']?['branch']),
            SizedBox(height: 6),
            _buildInfoRow("Account Status", "Verified"),
            SizedBox(height: 46),
            Padding(
              padding: const EdgeInsets.only(right: 260.0),
              child: Text(
                'Preferences',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                ),
              ),
            ),
            SizedBox(height: 8),
            _buildPreferenceContainer(
              icon: Icons.edit,
              label: "Edit Profile",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditProfile()), // Navigate to EditProfile
                );
              },
            ),
            SizedBox(height: 8),
            _buildPreferenceContainer(
              icon: Icons.logout,
              label: "Logout",
              onTap: () async {
                // Logout action
                try {
                  await FirebaseAuth.instance.signOut(); // Sign out from Firebase
                  // Navigate to the login screen
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WelcomeScreen(), // Replace with your actual login screen
                    ),
                  );
                } catch (e) {
                  print('Error logging out: $e'); // Handle any errors that occur during logout
                }
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.blue,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/Icons/Home page/Home.png",
              height: 25,
              color: _currentIndex == 0 ? Colors.white : null,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/Icons/Home page/community.png",
              height: 25,
              color: _currentIndex == 1 ? Colors.white : null,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/Icons/Home page/markeptplace.png",
              height: 25,
              color: _currentIndex == 2 ? Colors.white : null,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/Icons/Home page/profile.png",
              height: 25,
              color: _currentIndex == 3 ? Colors.white : null,
            ),
            label: '',
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });

          if (index == 2) {
            // Navigate to Marketplace page
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MarketPlaceScreen(), // Replace with your Marketplace page widget
              ),
            );
          } else if (index == 3) {
            // Handle other navigation if needed, but avoid reloading ProfilePage if already selected
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ProfilePage(), // Replace with appropriate widget
              ),
            );
          } else if (index == 0) {
            // Handle other navigation if needed, but avoid reloading ProfilePage if already selected
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MyHomePage(title: 'Campus Connect'), // Replace with appropriate widget
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildInfoRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w400,
              color: Colors.black87,
            ),
          ),
          Text(
            value ?? 'Not available',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.normal,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreferenceContainer({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              spreadRadius: 1,
              blurRadius: 5,
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.grey),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
