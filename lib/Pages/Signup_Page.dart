import 'package:campus_connect/Pages/Home_Page.dart';
import 'package:campus_connect/Pages/Login_Page.dart';
import 'package:campus_connect/Pages/Ui_Helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';


class SignupPage extends StatefulWidget {

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController PasswordController= TextEditingController();

  SignUp(String email,String password)async{
    if(email=="" && password==""){
      UIHelper.CustomAlertBox(context,"Enter the required field ");
    }
    else{
      UserCredential? usercredential;
      try{
        //this will try ki agr user ek valid value daal rha h
        //to ek nya user create krke dede
        usercredential=await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> MyHomePage(title: 'DEMO')));
        });

      }
      //agr mene email or password daal dia or dobara same email password s
      //enter krne ka try kia ya fr network issue hua to un sbko handle krega
      on FirebaseAuthException catch(ex){
        return UIHelper.CustomAlertBox(context, ex.code.toString());
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
          icon: Icon(Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,),


        ), systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text("Sign up",

                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,

                    ),),
                  SizedBox(height: 10,),
                  Text("Create an account, it's free",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        color:Colors.grey[700]),)


                ],
              ),

              Column(
                children: <Widget>[
                  inputFile(label: "Username",Icon: Icon(Icons.person)),
                  inputFile(controller: emailController,label: "Email",Icon: Icon(Icons.email)),
                  inputFile(controller: PasswordController,label: "Password", obscureText: true),
                  inputFile(label: "Confirm Password ", obscureText: true),
                ],
              ),
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
                  onPressed: () {

                    SignUp(emailController.text.toString(),PasswordController.text.toString());
                  },
                  color: Color(0xff0095FF),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),

                  ),
                  child: Text(
                    "Sign up", style: TextStyle(
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




// we will be creating a widget for text field
Widget inputFile({TextEditingController? controller,label, obscureText = false, Icon})
{
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        label,
        style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color:Colors.black87
        ),

      ),
      SizedBox(
        height: 5,
      ),
      TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          prefixIcon: Icon,
          contentPadding: EdgeInsets.symmetric(vertical: 0,
              horizontal: 10),
          border: OutlineInputBorder(
            borderSide: BorderSide(

            ),

          ),

        ),
      ),
      SizedBox(height: 10,)
    ],
  );
}