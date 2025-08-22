import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
// Removed import for the login screen as it's no longer needed

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController rollNoController = TextEditingController();
  final TextEditingController courseController = TextEditingController();
  final TextEditingController branchController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();

  File? _imageFile;
  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot doc = await _firestore.collection('users').doc(user.uid).get();
      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        nameController.text = data['chatIds']['name'] ?? '';
        rollNoController.text = data['chatIds']['rollNo'] ?? '';
        courseController.text = data['chatIds']['course'] ?? '';
        branchController.text = data['ads']['branch'] ?? '';
        phoneController.text = data['chatIds']['phoneNumber'] ?? '';
        _imageUrl = data['chatIds']['profileImgUrl']; // Load the image URL
        setState(() {}); // Trigger a rebuild to show the image
      }
    }
  }

  Future<void> _uploadImage() async {
    if (_imageFile != null) {
      User? user = _auth.currentUser;
      if (user != null) {
        try {
          final storageRef = _storage.ref().child('profile_images/${user.uid}.jpg');
          await storageRef.putFile(_imageFile!);
          String imageUrl = await storageRef.getDownloadURL();
          setState(() {
            _imageUrl = imageUrl; // Update the image URL
          });
          await _firestore.collection('users').doc(user.uid).update({
            'chatIds.profileImgUrl': imageUrl,
          });
        } catch (e) {
          print("Image upload error: $e");
        }
      }
    }
  }

  Future<void> _updateUserData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).update({
        'ads.branch': branchController.text,
        'chatIds.name': nameController.text,
        'chatIds.rollNo': rollNoController.text,
        'chatIds.course': courseController.text,
        'chatIds.phoneNumber': phoneController.text,
        if (_imageUrl != null) 'chatIds.profileImgUrl': _imageUrl,
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profile updated successfully')));
    }
  }

  Widget _buildTextField({required TextEditingController controller, required String labelText}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.blue),
        ),
      ),
    );
  }

  Widget AddImage() {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 55,
            backgroundImage: _imageFile != null
                ? FileImage(_imageFile!)
                : (_imageUrl != null && _imageUrl!.isNotEmpty
                ? NetworkImage(_imageUrl!)
                : AssetImage('assets/images/profile.png')) as ImageProvider,
            backgroundColor: Colors.white,
          ),
          Positioned(
            bottom: 8,
            right: -12,
            child: IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: ((builder) => BottomSheet()),
                );
              },
              icon: Icon(
                Icons.photo,
                color: Color(0xff0985e0),
                size: 25,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget BottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile Photo",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton.icon(
                icon: Icon(Icons.camera),
                label: Text(
                  'Camera',
                  style: TextStyle(color: Colors.black87),
                ),
                onPressed: () {
                  TakePhoto(ImageSource.camera);
                },
              ),
              TextButton.icon(
                icon: Icon(Icons.image),
                label: Text(
                  'Gallery',
                  style: TextStyle(color: Colors.black87),
                ),
                onPressed: () {
                  TakePhoto(ImageSource.gallery);
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  void TakePhoto(ImageSource source) async {
    final XFile? xFile = await _picker.pickImage(source: source);
    if (xFile != null) {
      setState(() {
        _imageFile = File(xFile.path);
      });
      Navigator.pop(context);
      await _uploadImage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        // Removed the logout button from the AppBar
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            AddImage(),
            SizedBox(height: 16),
            _buildTextField(controller: nameController, labelText: "Name"),
            SizedBox(height: 16),
            _buildTextField(controller: rollNoController, labelText: "Roll No."),
            SizedBox(height: 16),
            _buildTextField(controller: courseController, labelText: "Course"),
            SizedBox(height: 16),
            _buildTextField(controller: branchController, labelText: "Branch"),
            SizedBox(height: 16),
            _buildTextField(controller: phoneController, labelText: "Phone No."),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateUserData,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Color(0xFF1976D2), // White text color
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              child: Text("UPDATE"),
            ),
          ],
        ),
      ),
    );
  }
}
