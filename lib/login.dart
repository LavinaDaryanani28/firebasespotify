import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:spotifyfirebase/signup.dart';
import 'package:spotifyfirebase/uihelper.dart';

import 'home.dart';
import 'navbar.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  final format= DateFormat('yyy-mm-dd');
  DateTime date = DateTime.now();
  bool passwordVisible=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body:Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 60),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.network("https://play-lh.googleusercontent.com/7ynvVIRdhJNAngCg_GI7i8TtH8BqkJYmffeUHsG-mJOdzt1XLvGmbsKuc5Q1SInBjDKN=w240-h480-rw",height: 120,width: 120,),
              Center(child:
              UiHelper.customText("Spotify",color: Colors.white,fontsize: 40),
                // Text("Spotify",style: TextStyle(color: Colors.white,fontSize: 40,))
              ),
              SizedBox(height: 60,),
              UiHelper.customTextField(emailController, "enter your email", icondata:Icons.email,focuscolor:Colors.grey,borderradius: 10),
              SizedBox(height: 30,),
              UiHelper.custompwd(pwdController, "enter your password",Colors.grey,"password",passwordVisible,() {
                setState(() {
                  passwordVisible = !passwordVisible;
                  log(passwordVisible.toString());
                },
                );
              },),
              Container(
                alignment: Alignment.bottomRight,
                child:
                UiHelper.customTextButton("Forgot password?",color: Colors.white),
                // TextButton(onPressed: (){login(emailController.text.toString(), pwdController.text.toString());}, child: Text("Forgot password?", style: TextStyle(color: Colors.white),))
              ),
              SizedBox(height: 30,),
              SizedBox(
                height: 50,
                child: Center(
                  child: SizedBox(
                    height:60,
                    width:350,
                    child:
                    UiHelper.customButton("Login", fontsize: 25,  borderradius: 25, bgcolor:Colors.greenAccent.shade400, forecolor:Colors.black,callback: (){ signIn(emailController.text.toString(),pwdController.text.toString());}),
                    // ElevatedButton(onPressed:(){ login(emailController.text.toString(), pwdController.text.toString());} , child: Text("Login",style: TextStyle(fontSize: 25),),
                    //   style: ElevatedButton.styleFrom( shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(25)
                    //   ),backgroundColor: Colors.greenAccent.shade400,foregroundColor: Colors.black),),
                  ),
                ),
              ),
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network("https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/1024px-Google_%22G%22_logo.svg.png",height: 30,width: 30,),
                  SizedBox(width: 30,),
                  Image.network("https://1000logos.net/wp-content/uploads/2017/02/Facebook-Logosu.png",height: 50,width: 50,),
                ],
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  UiHelper.customText("Don't have an account?",color: Colors.white),
                  // Text("Don't have an account?",style: TextStyle(color: Colors.white),),
                  UiHelper.customTextButton("Sign up",color: Colors.green,callback: () {
                    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>Signin()));
                  }),
                  // TextButton(onPressed: (){}, child: Text("Sign up",style: TextStyle(color: Colors.green),))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  signIn(String email,String password)async{
    if(email=="" && password==""){
      return UiHelper.CustomAlertBox(context,"Enter Required Fields");
    }
    else{
      UserCredential? usercredential;
      try{
        usercredential=await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>NavBar()));
        });
      }
      on FirebaseAuthException catch(ex){
        return UiHelper.CustomAlertBox(context,ex.code.toString());
      }

    }
  }
}

