import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:spotifyfirebase/login.dart';
import 'package:spotifyfirebase/signup.dart';
import 'package:spotifyfirebase/uihelper.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingsState();
}

class _SettingsState extends State<Setting> {
  bool isSwitched = false;

  void _toggleSwitch(bool value) {
    setState(() {
      isSwitched = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 80),
          child: Center(child: UiHelper.customText("Settings", color: Colors.white),)
        ),
        backgroundColor: Colors.grey.shade900,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 100,
                child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: const Icon(
                          Icons.person,
                          size: 40,
                        ),
                        title: UiHelper.customText("Accountname",
                            color: Colors.white, fontsize: 25),
                        subtitle: Row(
                          children: [
                            UiHelper.customTextButton("Edit  profile",
                                color: Colors.white, fontsize: 15),
                          ],
                        ),
                      );
                    }),
              ),
              ExpansionTile(
                title: UiHelper.customText("Account",
                    color: Colors.white, fontsize: 20),
                childrenPadding: EdgeInsets.only(left: 40),
                children: [
                  UiHelper.customListTile("Free Plan", Colors.white, 15),
                  UiHelper.customListTile("Email", Colors.white, 15),
                ],
              ),
              ExpansionTile(
                title: UiHelper.customText("Content Preference",
                    color: Colors.white, fontsize: 20),
                childrenPadding: EdgeInsets.only(left: 40),
                children: [
                  ListTile(
                    title: Row(
                      children: [
                        UiHelper.customText("Allow Explicit content",
                            color: Colors.white, fontsize: 15),
                        SizedBox(
                          width: 75,
                        ),
                        Switch(
                          value: isSwitched,
                          onChanged: _toggleSwitch,
                          activeTrackColor: Colors.lightGreenAccent,
                          activeColor: Colors.green,
                        ),
                      ],
                    ),
                    onTap: () {},
                  ),
                ],
              ),
              ExpansionTile(
                title: UiHelper.customText("Playback",
                    color: Colors.white, fontsize: 20),
                childrenPadding: EdgeInsets.only(left: 40),
                children: [
                  ListTile(
                    title: Row(
                      children: [
                        UiHelper.customText("Gapless",
                            color: Colors.white, fontsize: 15),
                        SizedBox(
                          width: 170,
                        ),
                        Switch(
                          value: isSwitched,
                          onChanged: _toggleSwitch,
                          activeTrackColor: Colors.lightGreenAccent,
                          activeColor: Colors.green,
                        ),
                      ],
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        UiHelper.customText("Automix",
                            color: Colors.white, fontsize: 15),
                        SizedBox(
                          width: 170,
                        ),
                        Switch(
                          value: isSwitched,
                          onChanged: _toggleSwitch,
                          activeTrackColor: Colors.lightGreenAccent,
                          activeColor: Colors.green,
                        ),
                      ],
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        UiHelper.customText("Show unplayable songs",
                            color: Colors.white, fontsize: 15),
                        SizedBox(
                          width: 65,
                        ),
                        Switch(
                          value: isSwitched,
                          onChanged: _toggleSwitch,
                          activeTrackColor: Colors.lightGreenAccent,
                          activeColor: Colors.green,
                        ),
                      ],
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        UiHelper.customText("Canvas",
                            color: Colors.white, fontsize: 15),
                        SizedBox(
                          width: 180,
                        ),
                        Switch(
                          value: isSwitched,
                          onChanged: _toggleSwitch,
                          activeTrackColor: Colors.lightGreenAccent,
                          activeColor: Colors.green,
                        ),
                      ],
                    ),
                    onTap: () {},
                  )
                ],
              ),
              ExpansionTile(
                title: UiHelper.customText("Languages",
                    color: Colors.white, fontsize: 20),
                childrenPadding: EdgeInsets.only(left: 40),
                children: [
                  UiHelper.customListTile("App language", Colors.white, 15),
                  UiHelper.customListTile(
                      "Language for music", Colors.white, 15),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: UiHelper.customTextButton("About",
                    color: Colors.white, fontsize: 20),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: UiHelper.customTextButton("Log out",
                    color: Colors.white, fontsize: 20, callback: () {
                      UiHelper.CustomAlertBox(context, "are you sure you want to logout?",alertbtn:"logout",navigateTo: Login());
                    }),
              )
            ],
          ),
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}