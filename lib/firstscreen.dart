import 'package:flutter/material.dart';
import 'package:spotifyfirebase/uihelper.dart';

class Firstscreen extends StatefulWidget {
  const Firstscreen({super.key});

  @override
  State<Firstscreen> createState() => _FirstscreenState();
}

class _FirstscreenState extends State<Firstscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        // crossAxisAlignment:CrossAxisAlignment.center,
          children:[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 150,vertical: 20),
              child: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQb8oDHO4PTBdeShGL_WSI7zPnEBwD8f0kLaw&s",height: 150,width: 150,),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child:
              UiHelper.customText("Millions of songs.\nFree on spotify.",color:Colors.white,fontsize: 30,fontweight: FontWeight.bold,align: TextAlign.center,),
              // Text("Millions of songs.\nFree on spotify.",style: TextStyle(color:Colors.white,fontSize: 30,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),
            ),
            SizedBox(
              height:30,),
            Center(
              child: UiHelper.customButton("Sign up free", fontsize: 20, fontweight:FontWeight.bold, borderradius: 25, bgcolor:Colors.greenAccent.shade400, forecolor:Colors.black,height: 60,width: 350),
            ),
            SizedBox(height: 30,),
            Center(
              child: SizedBox(
                height: 60,
                width: 350,
                child: UiHelper.customRowButton("https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/1024px-Google_%22G%22_logo.svg.png", "Continue with Google", 15, 12, 20, 20, FontWeight.bold, Colors.white, 25, 1.0, Colors.white),
              ),
            ),
            SizedBox(height: 30,),
            Center(
              child: SizedBox(
                height: 60,
                width: 350,
                child: UiHelper.customRowButton("https://1000logos.net/wp-content/uploads/2017/02/Facebook-Logosu.png", "Continue with Facebook", 15, 12, 20, 20, FontWeight.bold, Colors.white, 25, 1.0, Colors.white),
              ),
            ),
            SizedBox(height: 30,),
            Center(
              child: SizedBox(
                height: 60,
                width: 350,
                child: UiHelper.customRowButton("https://pngimg.com/d/apple_logo_PNG19680.png","Continue with Apple", 15, 12, 20,  20, FontWeight.bold, Colors.white, 25, 1.0, Colors.white),
              ),
            ),
            SizedBox(height: 30,),
            Center(
              child: UiHelper.customTextButton("Log in",color:Colors.white,fontweight:FontWeight.bold,fontsize: 25),
            ),
            // Center(
            //   child: SizedBox(
            //     height:60,
            //     width:350,
            //     child:
            //     ElevatedButton(onPressed:(){  Navigator.push(context, MaterialPageRoute(builder: (context)=>Signin()));} , child: Text("Sign up free",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            //       style: ElevatedButton.styleFrom( shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(25)
            //     ),backgroundColor: Colors.greenAccent.shade400,foregroundColor: Colors.black),),
            //   ),
            // ),
            // SizedBox(
            //   height:30,),
            // Center(
            //     child: SizedBox(
            //     height:60,
            //     width:350,
            //     child:
            //         OutlinedButton(onPressed: (){},child: Row(children:[
            //         Padding(
            //           padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 12),
            //           child:
            //           Image.network("https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/1024px-Google_%22G%22_logo.svg.png"),
            //           // Image.asset("assets/images/google.png",height: 50,width: 80,),
            //         ),
            //           SizedBox(width: 20,),
            //           UiHelper.customText("Continue with Google",fontsize: 20,fontweight: FontWeight.bold,color: Colors.white),
            //           // Text("Continue with Google",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white)),
            //       ]),
            //       // Image.network("https://www.freepnglogos.com/uploads/google-logo-png/google-logo-png-google-icon-logo-png-transparent-svg-vector-bie-supply-14.png"),
            //           style: OutlinedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),side: BorderSide(width: 1.0, color: Colors.white),),
            //    ),
            //
            // ),),
            // SizedBox(
            //   height:30,),
            // Center(
            //   child: SizedBox(
            //     height:60,
            //     width:350,
            //     child:
            //         // UiHelper.CustomButton((){}, "https://1000logos.net/wp-content/uploads/2017/02/Facebook-Logosu.png", "Continue with Facebook",
            //         //     25, backgroundcolor, foregroundColor, fontweight, fontsize, horizontal, vertical, width),
            //     OutlinedButton(onPressed: (){},child: Row(children:[
            //       Padding(
            //         padding: const EdgeInsets.symmetric(vertical: 12),
            //         child:
            //         Image.network("https://1000logos.net/wp-content/uploads/2017/02/Facebook-Logosu.png"),
            //       ),
            //       SizedBox(width: 10,),
            //       UiHelper.customText("Continue with Facebook",fontsize: 20,fontweight: FontWeight.bold,color: Colors.white),
            //       // Text("Continue with Facebook",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white)),
            //     ]),
            //       // Image.network("https://www.freepnglogos.com/uploads/google-logo-png/google-logo-png-google-icon-logo-png-transparent-svg-vector-bie-supply-14.png"),
            //       style: OutlinedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),side: BorderSide(width: 1.0, color: Colors.white),),
            //     ),
            //
            //   ),),
            // SizedBox(
            //   height:30,),
            // Center(
            //   child: SizedBox(
            //     height:60,
            //     width:350,
            //     child:
            //     OutlinedButton(onPressed: (){},child: Row(children:[
            //       Padding(
            //         padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 15),
            //         child:
            //         Image.network("https://pngimg.com/d/apple_logo_PNG19680.png"),
            //       ),
            //       SizedBox(width: 15,),
            //       UiHelper.customText("Continue with Apple",fontsize: 20,fontweight: FontWeight.bold,color: Colors.white),
            //       // Text("Continue with Apple",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white)),
            //     ]),
            //       style: OutlinedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),side: BorderSide(width: 1.0, color: Colors.white),),
            //     ),
            //   ),),
            // SizedBox(
            //   height:40,),
            // Center(
            //   child: TextButton(child:Text("Log in",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25)),
            //   onPressed: (){  Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));},),
            //   ),
          ]),
      backgroundColor: Colors.black,
    );
  }
}
