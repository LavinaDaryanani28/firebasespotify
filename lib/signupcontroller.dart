import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spotifyfirebase/uihelper.dart';

class SignupController{
  static signup(BuildContext context,String email,String password,String username,String date)async{
    final bool emailValid =
    RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    if(email=="" || password==""||username==""||date==""){
      return UiHelper.CustomAlertBox(context, "Enter Required Field's");
    }
    else{
      if(!emailValid)
      {
        return UiHelper.CustomAlertBox(context, "Enter Valid Email");
      }
      else {
        // context.read<SignUpBloc>().signUp(email, password, username);
      }
    }
  }
  static onTapFunction({required BuildContext context,TextEditingController? dateController}) async {
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