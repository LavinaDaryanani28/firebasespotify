import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotifyfirebase/signup.dart';

class UiHelper {
  static customButton(String text,
      {double? fontsize,
      FontWeight? fontweight,
      double? borderradius,
      Color? bgcolor,
      Color? forecolor,
      double? height,
      double? width,
      VoidCallback? callback,
      double? side,
      Color? sidecolor}) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: () {
          callback!();
        },
        child: Text(
          text,
          style: TextStyle(fontSize: fontsize, fontWeight: fontweight),
        ),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  borderradius != null ? borderradius : 0.0),
              side: BorderSide(width: 1.0, color: Colors.white)),
          backgroundColor: bgcolor,
          foregroundColor: forecolor,
        ),
      ),
    );
  }

  static customRowButton(String imgpath, String text,
      [double? vpadding,
      double? hpadding,
      double? sizeboxwidth,
      double? fontsize,
      FontWeight? fontweight,
      Color? txtcolor,
      double? borderradius,
      double? bordersidewidth,
      Color? bordercolor,
      VoidCallback? callback]) {
    return OutlinedButton(
      onPressed: () {},
      child: Row(children: [
        Padding(
          padding:
              EdgeInsets.symmetric(vertical: vpadding!, horizontal: hpadding!),
          child: Image.network(imgpath),
        ),
        customSizebox(width: sizeboxwidth),
        Text(text,
            style: TextStyle(
                fontSize: fontsize, fontWeight: fontweight, color: txtcolor)),
      ]),
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderradius!)),
        side: BorderSide(width: bordersidewidth!, color: bordercolor!),
      ),
    );
  }

  static customSizebox({double? width, double? height}) {
    return SizedBox(
      height: height,
      width: width,
    );
  }

  static customTextField(TextEditingController controller, String text,
      {IconData? icondata,
      Color? focuscolor,
      double? borderradius,
      bool? password,
      VoidCallback? callback}) {
    return TextField(
      controller: controller,
      obscureText: password != null ? true : false,
      decoration: InputDecoration(
          hintText: text,
          suffixIcon: Icon(icondata),
          filled: true,
          focusColor: focuscolor,
          border: OutlineInputBorder(
            borderRadius: borderradius != null
                ? BorderRadius.circular(borderradius)
                : BorderRadius.circular(0.0),
          )),
    );
  }

  static customText(String text,
      {Color? color,
      double? fontsize,
      FontWeight? fontweight,
      TextAlign? align}) {
    return Text(
      overflow: TextOverflow.ellipsis,
      text,
      style:
          TextStyle(fontSize: fontsize, color: color, fontWeight: fontweight),
      maxLines: 1,
      textAlign: align,
    );
  }

  static CustomAlertBox(BuildContext context, String text,
      {String? alertbtn, dynamic? navigateTo, VoidCallback? callback}) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(text),
            actions: alertbtn == "logout" || alertbtn == "createPlaylist"
                ? [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Cancel'),
                    ),
                    alertbtn == "logout"
                        ? TextButton(
                            onPressed: () async {
                              SharedPreferences preferences =
                                  await SharedPreferences.getInstance();
                              await preferences.clear();
                              await FirebaseAuth.instance.signOut();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => navigateTo!));
                            },
                            child: Text('OK'),
                          )
                        : alertbtn == "createPlaylist"
                            ? TextButton(
                                onPressed: () {
                                  callback!();
                                },
                                child: Text('Ok'),
                              )
                            : Text("Hello"),
                  ]
                : [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("ok"))
                  ],
          );
        });
  }

  static customTextButton(String text,
      {Color? color,
      FontWeight? fontweight,
      double? fontsize,
      VoidCallback? callback}) {
    return TextButton(
        onPressed: () {
          callback!();
        },
        child: Text(text,
            style: TextStyle(
                color: color, fontWeight: fontweight, fontSize: fontsize)));
  }

  static expansionTile(String text, Color color, double fontsize,
      String listText, Color listcolor, double listfontsize,
      {VoidCallback? callback,
      double? width,
      bool? isSwitched,
      VoidCallback? callbackChange}) {
    return ExpansionTile(
      title: UiHelper.customText(text, color: color, fontsize: fontsize),
      childrenPadding: EdgeInsets.only(left: 40),
      children: [
        UiHelper.customListTile(listText, listcolor, listfontsize,
            callback: callback),
      ],
    );
  }

  static customListTile(String text, Color color, double fontsize,
      {VoidCallback? callback}) {
    return ListTile(
      title: UiHelper.customText(text, color: color, fontsize: fontsize),
      onTap: () {
        callback!();
      },
    );
  }

  static iconBtn(double IconSize,
      {Color? color,
      IconData? icondata,
      VoidCallback? callback,
      bool? image,
      String? imagePath,
      double? height,
      double? width}) {
    return IconButton(
      onPressed: () {
        callback!();
      },
      icon: image == true
          ? Image.network(
              imagePath!,
              height: height,
              width: width,
            )
          : Icon(
              icondata!,
              color: color,
            ),
      iconSize: IconSize,
    );
  }

  static customOutlinebtn(
    double borderradius,
    double side,
    String text,
    double fontsize,
    FontWeight fontweight,
    Color color,
    Color sideColor, {
    VoidCallback? callback,
  }) {
    return OutlinedButton(
      onPressed: () {
        callback!();
      },
      child: UiHelper.customText(text,
          fontsize: fontsize, fontweight: fontweight, color: color),
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderradius)),
        side: BorderSide(width: side, color: sideColor),
      ),
    );
  }

  static custompwd(TextEditingController controller, String text, Color color,
      [String? params, bool? password, VoidCallback? callback]) {
    return TextField(
      controller: controller,
      obscureText: password!,
      decoration: InputDecoration(
          hintText: text,
          suffixIcon: IconButton(
            icon: Icon(password ? Icons.visibility_off : Icons.visibility),
            onPressed: callback,
          ),
          filled: true,
          focusColor: Colors.grey,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );
  }
}