import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spotifyfirebase/uihelper.dart';
import 'login.dart';

class SignupController {
  static signup(BuildContext context, String email, String password,
      String username, String date) async {
    //expression to check the email format
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);

    //if any field is empty
    if (email == "" || password == "" || username == "" || date == "") {
      return UiHelper.CustomAlertBox(context, "Enter Required Field's");
    } else {
      //if the email format is not valid
      if (!emailValid) {
        return UiHelper.CustomAlertBox(context, "Enter Valid Email");
      } else {
        //connecting with database if all fields are valid
        UserCredential? userCredential;
        try {
          userCredential = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: email, password: password)
              .then((value) {
            return Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Login()));
          });
        } on FirebaseAuthException catch (ex) {
          return UiHelper.CustomAlertBox(context, ex.code.toString());
        }
      }
    }
  }

  static onTapFunction(
      {required BuildContext context,
      TextEditingController? dateController}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      lastDate: DateTime.now(),
      firstDate: DateTime(2015),
      initialDate: DateTime.now(),
    );
    if (pickedDate == null) return;
    dateController!.text = DateFormat('dd-MM-yyyy').format(pickedDate);
  }
}
