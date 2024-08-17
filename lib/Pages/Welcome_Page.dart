import 'package:campus_connect/Pages/Login_Page.dart';
import 'package:campus_connect/Pages/Signup_Page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class WelcomeScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
      appBar:AppBar(),
      body:
        Container(
        //we will use double.infinity to make this container as big as my parent allows
        //we will use mediaquery to make it as big as my screen size
          width: double.infinity,
          constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.8),
          padding: EdgeInsets.symmetric(horizontal: 30,vertical:30),
            child:
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:<Widget>[
              Expanded(
                child: Column(
                  //even space distribution
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:<Widget>
                [
                  Text(
                    'Welcome to Campus Connect',
                     textAlign: TextAlign.center,
                    style:TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    )
                  ),

                  Text(
                    'Let us Redefine Campus Life',
                    textAlign: TextAlign.center,
                    style:TextStyle(
                      fontSize: 20,
                      color: Colors.black54,
                    )
                  ),
                  Container(
                    height:270,
                    width: 270,
                    child:Image.asset("assets/images/welcome.png"),
                  ),
                Column(
                children:<Widget> [
                  MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                
                      },
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Colors.black87,
                        ),
                        borderRadius:BorderRadius.circular(50),
                      ),
                    child:Text(
                      'Login',
                      style:TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      )
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  //Creating the Signup button
                  Container(
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
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupPage()));
                      },
                      color: Color(0xff0095FF),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Colors.black54,
                        ),
                        borderRadius:BorderRadius.circular(50),
                      ),
                      child:Text(
                          'Sign Up',
                          style:TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          )
                      ),
                    ),
                  ),
                ],
                          )
                
                ],
                ),
              ), ],
              ),




        )
    );

  }

}