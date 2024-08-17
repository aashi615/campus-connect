import 'package:campus_connect/Pages/Home_Page.dart';
import 'package:campus_connect/Pages/Signup_Page.dart';
import 'package:campus_connect/main.dart';
import 'package:flutter/material.dart';
class LoginPage extends StatefulWidget{

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     resizeToAvoidBottomInset: false,
     backgroundColor: Colors.white,
     appBar: AppBar(
       backgroundColor: Colors.white,
       elevation: 0,
       leading: IconButton(
         onPressed: (){
           Navigator.pop(context);
         },
         icon: Icon(Icons.arrow_back_ios,
             size:20,
             color: Colors.black,
         ),


       ),
     ),
     body:
     Container(
       height: MediaQuery.of(context).size.height,
       width: double.infinity,
       child: Column(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: <Widget>[
           Expanded(child: Column(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: <Widget>[
               Column(
                 children: <Widget>[
                   Text("Login",
                     style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                   SizedBox(height: 15,),
                   Text("Login to your account",
                     style: TextStyle(
                         fontSize: 15,
                         color:Colors.black),)
                 ],
               ),
               Padding(
                 padding: EdgeInsets.symmetric(horizontal: 40),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,

                     children: <Widget>[
                       Text(
                         'Email',
                         style: TextStyle(
                             fontSize: 15,
                             fontWeight: FontWeight.w400,
                             color: Colors.black87
                         ),
                       ),
                       SizedBox(height: 10,),
                       TextField(

                         decoration: InputDecoration(
                           prefixIcon: Icon(Icons.email,color: Colors.grey.shade700,),
                           contentPadding: EdgeInsets.symmetric(vertical: 0,
                               horizontal: 10),
                           border: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(5),
                             borderSide: BorderSide(
                               color: Color(0xff0095FF),
                             ),
                           ),
                         ),
                       ),
                       SizedBox(height:10),
                       Text(
                         'Password',
                         style: TextStyle(
                             fontSize: 15,
                             fontWeight: FontWeight.w400,
                             color: Colors.black87
                         ),
                       ),
                       SizedBox(height: 10,),
                       TextField(
                         obscureText: true,
                         decoration: InputDecoration(
                           contentPadding: EdgeInsets.symmetric(vertical: 0,
                               horizontal: 10),
                           border: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(5),
                             borderSide: BorderSide(
                               color: Color(0xff0095FF),
                             ),
                           ),
                         ),
                       ),
                   ]
                 ),
               ),
               SizedBox(height: 10,),
               //This whole container code snipet is for my login button
               Padding(padding:
               EdgeInsets.symmetric(horizontal: 40),
                 child: Container(
                   padding: EdgeInsets.only(top: 3, left: 3),
                   decoration:
                   BoxDecoration(
                       borderRadius: BorderRadius.circular(50),
                       border: Border(
                         bottom: BorderSide(color: Colors.black),
                         top: BorderSide(color: Colors.black),
                         left: BorderSide(color: Colors.black),
                         right: BorderSide(color: Colors.black),

                       )



                   ),
                   child: MaterialButton(
                     minWidth: double.infinity,
                     height: 60,
                     onPressed: () {
                       Navigator.push(context, MaterialPageRoute(builder: (context) =>MyHomePage(title: 'Home',)));

                     },
                     color: Color(0xff0095FF),
                     elevation: 0,
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(50),

                     ),
                     child: Text(
                       "Login", style: TextStyle(
                       fontWeight: FontWeight.w600,
                       fontSize: 18,
                       color: Colors.white,

                     ),
                     ),

                   ),
                 ),
               ),


               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: <Widget>[
                   Text("Don't have an account?"),
                   TextButton(
                     onPressed: (){
                     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignupPage()));
                     },child:Text("SignUp",style:TextStyle(fontSize: 20,fontWeight: FontWeight.w500)),
                   )
                 ],
               ),

               Container(
                   padding: EdgeInsets.only(top: 50),
                   height: 270,
                   width: 270,
                   child:Image.asset("assets/images/background.png")
               )

             ],
           ))
         ],
       ),
     ),
   );
  }
}


// we will be creating a widget for text field
Widget inputFile({label, obscureText = false}) {
  return Column(


    children: [ TextField(

        obscureText: obscureText,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 0,
              horizontal: 10),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(

            ),

          ),

        ),
      ),
      SizedBox(height: 10,)
    ],
  );
}