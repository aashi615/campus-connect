import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddItem extends StatefulWidget {
  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController usedFrequencyController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();
  String _imageUrl = '';
  String uid = FirebaseAuth.instance.currentUser?.uid ?? "default-uid";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xff0095FF),
        title: Text(
          'Campus Market',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 25,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 22),
          child: Column(
            children: [
              Center(
                child: Text(
                  "Add Product Details",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 27,
                    color: Color(0xff0070A3),
                  ),
                ),
              ),
              SizedBox(height: 25),
              // Image picker UI
              _buildImagePicker(),
              SizedBox(height: 20),
              _buildTextField('Title', titleController),
              SizedBox(height: 10),
              _buildDescriptionField('Description', descriptionController),
              SizedBox(height: 10),
              _buildTextField('Used Frequency', usedFrequencyController),
              SizedBox(height: 10),
              _buildTextField('Price', priceController),
              SizedBox(height: 20),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImagePicker() {
    return Container(
      height: 120,
      width: 150,
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: Colors.grey),
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(width: 2, color: Colors.grey),
              color: Colors.grey[200],
              image: _imageFile != null
                  ? DecorationImage(
                image: FileImage(File(_imageFile!.path)),
                fit: BoxFit.cover,
              )
                  : null,
            ),
          ),
          Positioned(
            right: -12,
            child: IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (builder) => _bottomSheet(),
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

  Widget _bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery
          .of(context)
          .size
          .width,
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
                label: Text('Camera', style: TextStyle(color: Colors.black87)),
                onPressed: () {
                  _takePhoto(ImageSource.camera);
                },
              ),
              TextButton.icon(
                icon: Icon(Icons.image),
                label: Text('Gallery', style: TextStyle(color: Colors.black87)),
                onPressed: () {
                  _takePhoto(ImageSource.gallery);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _takePhoto(ImageSource source) async {
    final XFile? xFile = await _picker.pickImage(source: source);
    if (xFile != null) {
      setState(() {
        _imageFile = xFile;
      });
    }
  }

  Widget _buildTextField(String hint, TextEditingController controller) {
    return Container(
      height: 45,
      width: 350,
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: Colors.grey),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, top: 10),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            border: InputBorder.none,
          ),
          style: TextStyle(fontSize: 15),
        ),
      ),
    );
  }

  Widget _buildDescriptionField(String hint, TextEditingController controller) {
    return Container(
      height: 120,
      width: 350,
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: Colors.grey),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, top: 10),
        child: TextField(
          controller: controller,
          maxLines: 6,
          decoration: InputDecoration(
            hintText: hint,
            border: InputBorder.none,
          ),
          style: TextStyle(fontSize: 15),
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return InkWell(
      onTap: () async {
        if (titleController.text.isEmpty ||
            descriptionController.text.isEmpty ||
            usedFrequencyController.text.isEmpty ||
            priceController.text.isEmpty) {
          // Show a SnackBar if any field is empty
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Please fill in all fields ')),
          );
          return; // Exit the method if validation fails
        }
        if (_imageFile == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Please upload the image')),
          );
          return;
        }

        try {
          String uniqueFileName = DateTime
              .now()
              .millisecondsSinceEpoch
              .toString();
          Reference referenceRoot = FirebaseStorage.instance.ref();
          Reference referenceDirImages = referenceRoot.child('Ads');
          Reference referenceImageToUpload = referenceDirImages.child(
              uniqueFileName);

          await referenceImageToUpload.putFile(File(_imageFile!.path));
          _imageUrl = await referenceImageToUpload.getDownloadURL();

          if (_imageUrl.isNotEmpty) {

            Map<String, dynamic> productDetails = {
              "des": descriptionController.text,
              "id": uniqueFileName,
              "images": {
                "price": priceController.text,
                "title": titleController.text,
                "uid": uid,
                "used": usedFrequencyController.text,
                "imageUrl": _imageUrl,
              },
            };

            // Add to Firestore
            CollectionReference collectionReference =
            FirebaseFirestore.instance.collection('Ads');
            await collectionReference.add(productDetails);

            // Optionally, show a success message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Product added successfully')),
            );

            // Clear the form
            titleController.clear();
            descriptionController.clear();
            usedFrequencyController.clear();
            priceController.clear();
            setState(() {
              _imageFile = null;
            });
          }
        } catch (error) {
          print("Error uploading image: $error");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error adding product: $error')),
          );
        }
      },
      child: Container(
        height: 50,
        width: 150,
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 33.0),
          child: Text(
            'Update',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Color(0xff0070A3),
        ),
      ),
    );
  }
}
