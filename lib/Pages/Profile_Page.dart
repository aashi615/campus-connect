import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController nameController= TextEditingController();
  TextEditingController CourseController= TextEditingController();
  TextEditingController BranchController= TextEditingController();
  TextEditingController YearController= TextEditingController();
  TextEditingController LinkedinController= TextEditingController();
  TextEditingController GithubController= TextEditingController();
  TextEditingController InterestController= TextEditingController();
   PickedFile? _imageFile=null;
  final ImagePicker _picker = ImagePicker();
  String _imageUrl='';
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(),
     body:
       Padding(
         padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
         child: ListView(
          children: <Widget>[
            Center(
              child: Text('Create your Profile',
              style: TextStyle(
                fontWeight:FontWeight.bold,
                fontSize: 28,
                color: Color(0xff0070A3),

              ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            AddImage(),
              SizedBox(height: 20,),
              NameTextField(),
             SizedBox(
               height: 20,
             ),
            CourseTextField(),
            SizedBox(
              height: 20,
            ),
            BranchTextField(),
            SizedBox(
              height: 20,
            ),
            YearTextField(),
            SizedBox(
              height: 20,
            ),
            LinkedinTextField(),
            SizedBox(
              height: 20,
            ),
            GithubTextField(),
            SizedBox(
              height: 20,
            ),
            InterestsTextField(),
            SizedBox(
              height: 20,
            ),
            Center(
              child: InkWell(
                onTap: () async {
                  if (_imageFile == null) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please upload the image')));
                    return;
                  }

                  try {
                    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
                    Reference referenceRoot = FirebaseStorage.instance.ref();
                    Reference referenceDirImages = referenceRoot.child('ProfileImages');
                    Reference referenceImagetoUpload = referenceDirImages.child(uniqueFileName);

                    await referenceImagetoUpload.putFile(File(_imageFile!.path));
                    _imageUrl = await referenceImagetoUpload.getDownloadURL();

                    if (_imageUrl.isNotEmpty) {
                      Map<String,dynamic>userDetails={
                        "Name":nameController.text,
                        "Course":CourseController.text,
                        "Branch":BranchController.text,
                        "Year":YearController.text,
                        "linkedin":LinkedinController.text,
                        "Github":GithubController.text,
                        "Interests":InterestController.text,
                      };
                      CollectionReference collectionreference = FirebaseFirestore.instance.collection('user_profile');
                      collectionreference.add(userDetails);

                    }
                  } catch (error) {
                    print("Error uploading image: $error");
                    // Handle error if image upload fails
                  }


                },
                child: Container(
                  height:50,
                  width: 150,
                  child:Padding(
                    padding: const EdgeInsets.only(top:6.0,left: 33.0),
                    child: Text('Create',
                        style:TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Color(0xff0070A3),

                  ),
                ),
              ),
            )


           ],

            ),
       )
   );
  }

  Widget NameTextField() {
    return TextFormField(
      controller: nameController,
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.teal,
              )
          ),
        focusedBorder:OutlineInputBorder(
            borderSide: BorderSide(
              color:Color(0xff0095FF),
              width: 2,
            )
        ),
        prefixIcon: Icon(
          Icons.person,
          color: Color(0xff0095FF),
        ),
        label: Text('Enter your name',
        style: TextStyle(
          color: Colors.grey,
        ),
        ),
      ),

    );
  }
  Widget CourseTextField() {
    return TextFormField(
      controller: CourseController,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.teal,
            )
        ),
        focusedBorder:OutlineInputBorder(
            borderSide: BorderSide(
              color:Color(0xff0095FF),
              width: 2,
            )
        ),
        prefixIcon: Icon(
          Icons.book,
          color: Color(0xff0095FF),
        ),
        label: Text('Enter your Course',
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
      ),

    );
  }
  Widget BranchTextField() {
    return TextFormField(
      controller: BranchController,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.teal,
            )
        ),
        focusedBorder:OutlineInputBorder(
            borderSide: BorderSide(
              color:Color(0xff0095FF),
              width: 2,
            )
        ),
        prefixIcon: Icon(
          Icons.book_online,
          color: Color(0xff0095FF),
        ),
        label: Text('Enter your Branch',
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
      ),

    );
  }
  Widget YearTextField() {
    return TextFormField(
      controller: YearController,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.teal,
            )
        ),
        focusedBorder:OutlineInputBorder(
            borderSide: BorderSide(
              color:Color(0xff0095FF),
              width: 2,
            )
        ),
        prefixIcon: Icon(
          Icons.calendar_month,
          color: Color(0xff0095FF),
        ),
        label: Text('Enter your Year',
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
      ),

    );
  }
  Widget LinkedinTextField() {
    return TextFormField(
      controller: LinkedinController,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.teal,
            )
        ),
        focusedBorder:OutlineInputBorder(
            borderSide: BorderSide(
              color:Color(0xff0095FF),
              width: 2,
            )
        ),

        label: Text('Enter your LinkedIn account',
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
      ),

    );
  }
  Widget GithubTextField() {
    return TextFormField(
      controller: GithubController,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.teal,
            )
        ),
        focusedBorder:OutlineInputBorder(
            borderSide: BorderSide(
              color:Color(0xff0095FF),
              width: 2,
            )
        ),

        label: Text('Enter your Github account',
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
      ),

    );
  }
  Widget InterestsTextField() {
    return TextFormField(
      controller: InterestController,
      maxLines: 6,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.teal,
            )
        ),
        focusedBorder:OutlineInputBorder(
            borderSide: BorderSide(
              color:Color(0xff0095FF),
              width: 2,
            )
        ),
        prefixIcon: Icon(
          Icons.interests,
          color: Color(0xff0095FF),
        ),
        label: Text('Enter your Interests',
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
      ),

    );
  }
   Widget AddImage(){
     return Center(
       child: Stack(
           children:[
             CircleAvatar(
               radius: 55,
               // Later in your code...
               backgroundImage: _imageFile == null
                   ? AssetImage('assets/images/profile.png')
                   : FileImage(File(_imageFile!.path)) as ImageProvider<Object>?,

               backgroundColor: Colors.white,
             ),
             Positioned(
                 bottom: 8,
                 right: -12,
                 child: IconButton(onPressed: (){
                   showModalBottomSheet(
                     context:context,
                     builder:((builder)=> BottomSheet()),
                   );
                 },icon: Icon(Icons.photo,
                   color: Color(0xff0985e0),
                   size: 25,
                 ),))
           ]),
     );
   }

   Widget BottomSheet(){
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin:EdgeInsets.symmetric(horizontal: 20,vertical: 20),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile Photo",
            style:TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),
          ),
      SizedBox(
      height: 20,
    ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          TextButton.icon(
          icon: Icon(Icons.camera),
      label: Text('Camera',style: TextStyle(
        color: Colors.black87,
      ),),
      onPressed: () {
            TakePhoto(ImageSource.camera);
      },
    ),
              TextButton.icon(
                icon: Icon(Icons.image),
                label: Text('Gallery',style: TextStyle(
                  color: Colors.black87,
                ),),
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
       final pickedFile = PickedFile(xFile.path);
       setState(() {
         _imageFile = pickedFile;
       });
     }
   }
}