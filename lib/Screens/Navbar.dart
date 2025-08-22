import 'package:campus_connect/Screens/EditProfile_screen.dart';
import 'package:flutter/material.dart';
class Navbar extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Drawer(
     child: ListView(
       children: [
         UserAccountsDrawerHeader(
             accountName:Text('Aashi garg') ,
             accountEmail:Text('aashigarg975@gmail.com'),
             currentAccountPicture:CircleAvatar(
               child: ClipOval(
                 child: Image.asset('assets/images/my passport size photo.png',
                 width:90,
                   height: 90,
                   fit: BoxFit.cover,
                 ),

               )
             ),
           decoration:BoxDecoration(
             color: Color(0xff0095FF),
             
           )
            ,

         ),
       ListTile(
         leading:Icon(Icons.edit),
         title: Text('Create your profile',
         style:TextStyle(
           color: Colors.black87,
           fontSize: 18,
           fontWeight: FontWeight.bold
         )
         ),
         onTap: (){
           Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile()));
         },
       ),
         Divider(),
         ListTile(
           leading:Icon(Icons.settings),
           title: Text('Settings',
               style:TextStyle(
                   color: Colors.black87,
                   fontSize: 18,
                   fontWeight: FontWeight.bold
               )
           ),
           onTap: (){},
         ),
         Divider(),
       ]

     )
    );
  }

}