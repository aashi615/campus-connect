import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class AddItem extends StatefulWidget{
  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();
  TextEditingController usedfrequencycontroller = TextEditingController();
  TextEditingController pricecontroller = TextEditingController();
  PickedFile? _imageFile=null;
  final ImagePicker _picker = ImagePicker();
  String _imageUrl='';
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       automaticallyImplyLeading: false,
       backgroundColor: Color(0xff0095FF),
       title: Text('Campus Market',style: TextStyle(
         color: Colors.white,
         fontSize: 25,
         fontWeight: FontWeight.bold,
       ),
         textAlign: TextAlign.center,
       ),
       leading:  IconButton(
         onPressed: (){
           Navigator.pop(context);
         },
         icon: Icon(Icons.arrow_back_ios,
           size:25,
           color: Colors.white,
         ),
       ),
       actions: [
         IconButton(
           icon: SizedBox(
               height:25,
               width:30,
               child: Image.asset("assets/Icons/Home page/notifications.png")),
           onPressed: () {
             // Add your onPressed logic here
           },
         ),
       ],
     ),
     body:SingleChildScrollView(
       child: Padding(
         padding: const EdgeInsets.only(top:22),
         child: Column(
           children: [
             Center(
               child: Text("Add Product Details",
               style: TextStyle(
                 fontWeight: FontWeight.bold,
                 fontSize: 27,
                 color: Color(0xff0070A3),
               ),
               ),
             ),
             SizedBox(
               height: 25,
             ),
             Container(
               height: 120,
               width: 150,
               decoration: BoxDecoration(
                 border: Border.all(
                   width: 2,
                   color: Colors.grey,
                 ),
               ),
               child: Stack(
                 children: [
                   Container(
                       height: 120,
                       width: 150,
                       decoration: _imageFile == null
                           ? BoxDecoration(
                         image: DecorationImage(
                           image: AssetImage('assets/Icons/MarketPlace/TPO.png'),
                           fit: BoxFit.cover,
                         ),
                       )
                           : BoxDecoration(
                         image: DecorationImage(
                           image: FileImage(File(_imageFile!.path)),
                           fit: BoxFit.cover,
                         ),
                       ),
                     ),

                   Positioned(
                     right: -12,
                     child: Padding(
                       padding: const EdgeInsets.only(bottom: 8.0),
                       child: IconButton(
                         onPressed: () {
                           showModalBottomSheet(
                             context:context,
                             builder:((builder)=> BottomSheet()),
                           );
                         },
                         icon: Icon(
                           Icons.photo,
                           color: Color(0xff0985e0),
                           size: 25,
                         ),
                       ),
                     ),
                   ),
                 ],
               ),
             ),
             SizedBox(
               height: 20,
             ),
             Container(
               height:45,
               width: 350,
               decoration: BoxDecoration(
                 border: Border.all(
                   width:2,
                   color:Colors.grey,
                 ),
               ),
               child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children:[
                 Padding(
                   padding: const EdgeInsets.only(left:20.0),
                   child: Text('Choose Category',
                   style: TextStyle(
                     fontSize: 15,
                   ),),
                 ),
                 Image.asset("assets/Icons/MarketPlace/dropdown.png",
                 width: 20,
                 height: 20,
                 ),
               ]
               ),
             ),
             SizedBox(
               height: 10,
             ),
             Container(
               height: 45,
               width: 350,
               decoration: BoxDecoration(
                 border: Border.all(
                   width: 2,
                   color: Colors.grey,
                 ),
               ),
               child: Padding(
                 padding: const EdgeInsets.only(left: 20.0, top: 10),
                 child: TextField(
                   controller: titlecontroller,
                   decoration: InputDecoration(
                     hintText: 'Title',
                     border: InputBorder.none, // Remove border from TextField
                   ),
                   style: TextStyle(
                     fontSize: 15,
                   ),
                 ),
               ),
             ),
             SizedBox(
               height: 10,
             ),
             Container(
               height: 120,
               width: 350,
               decoration: BoxDecoration(
                 border: Border.all(
                   width: 2,
                   color: Colors.grey,
                 ),
               ),
               child: Padding(
                 padding: const EdgeInsets.only(left: 20.0, top: 10),
                 child: TextField(
                   controller: descriptioncontroller,
                   maxLines: 6,
                   decoration: InputDecoration(
                     hintText: 'Description',
                     border: InputBorder.none, // Remove border from TextField
                   ),
                   style: TextStyle(
                     fontSize: 15,
                   ),
                 ),
               ),
             ),
             SizedBox(
               height: 10,
             ),
             Container(
               height: 45,
               width: 350,
               decoration: BoxDecoration(
                 border: Border.all(
                   width: 2,
                   color: Colors.grey,
                 ),
               ),
               child: Padding(
                 padding: const EdgeInsets.only(left: 20.0, top: 10),
                 child: TextField(
                   controller: usedfrequencycontroller,
                   decoration: InputDecoration(
                     hintText: 'Used Frequency',
                     border: InputBorder.none, // Remove border from TextField
                   ),
                   style: TextStyle(
                     fontSize: 15,
                   ),
                 ),
               ),
             ),
             SizedBox(
               height: 10,
             ),
             Container(
               height: 45,
               width: 350,
               decoration: BoxDecoration(
                 border: Border.all(
                   width: 2,
                   color: Colors.grey,
                 ),
               ),
               child: Padding(
                 padding: const EdgeInsets.only(left: 20.0, top: 10),
                 child: TextField(
                   controller: pricecontroller,
                   decoration: InputDecoration(
                     hintText: 'Price',
                     border: InputBorder.none, // Remove border from TextField
                   ),
                   style: TextStyle(
                     fontSize: 15,
                   ),
                 ),
               ),
             ),
             SizedBox(
               height: 10,
             ),

             SizedBox(
               height: 20,
             ),
             InkWell(
               onTap: () async {
                 if (_imageFile == null) {
                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please upload the image')));
                   return;
                 }

                 try {
                   String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
                   Reference referenceRoot = FirebaseStorage.instance.ref();
                   Reference referenceDirImages = referenceRoot.child('MarketplaceImages');
                   Reference referenceImagetoUpload = referenceDirImages.child(uniqueFileName);

                   await referenceImagetoUpload.putFile(File(_imageFile!.path));
                   _imageUrl = await referenceImagetoUpload.getDownloadURL();

                   if (_imageUrl.isNotEmpty) {
                     Map<String, dynamic> productDetails = {
                       "Title": titlecontroller.text,
                       "Description": descriptioncontroller.text,
                       "used frequency": usedfrequencycontroller.text,
                       "Price": pricecontroller.text,
                       "image": _imageUrl
                     };

                     CollectionReference collectionReference = FirebaseFirestore.instance.collection('Product_details');
                     collectionReference.add(productDetails);
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
                   padding: const EdgeInsets.only(top:8.0,left: 33.0),
                   child: Text('Update',
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
             )
           ],
         ),
       ),
     ),
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
