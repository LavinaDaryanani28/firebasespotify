import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotifyfirebase/signup.dart';
import 'package:spotifyfirebase/uihelper.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
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
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 80),
          child: UiHelper.customText("Settings", color: Colors.white),
          // Text("Settings",style: TextStyle(color: Colors.white),),
        ),
        backgroundColor: Colors.grey.shade900,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 10),
              //   child: Row(
              //     children: [
              //       CircleAvatar(child: Icon(Icons.person),),
              //       SizedBox(width: 20,),
              //       Column(
              //         children: [
              //           Text("Accountname",style: TextStyle(color: Colors.white,fontSize: 25)),
              //           TextButton(onPressed: (){},child: Text("Edit Profile",style: TextStyle(color: Colors.white,fontSize: 15)),),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
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
                        // Text(
                        //       "Accountname",
                        //       style: TextStyle(color: Colors.white, fontSize: 25),),
                        subtitle: Row(
                          children: [
                            UiHelper.customTextButton("Edit  profile",
                                color: Colors.white, fontsize: 15),
                            // TextButton(
                            //   onPressed: (){},
                            //   child: Text(
                            //     "Edit profile",
                            //     style: TextStyle(color: Colors.white, fontSize: 15),),
                            // ),
                          ],
                        ),
                      );
                    }),
              ),
              // UiHelper.expansionTile("Account",Colors.white, 20,"Free Plan",Colors.white,15),
              ExpansionTile(
                title: UiHelper.customText("Account",
                    color: Colors.white, fontsize: 20),
                childrenPadding: EdgeInsets.only(left: 40),
                children: [
                  UiHelper.customListTile("Free Plan", Colors.white, 15),
                  // ListTile(
                  //   title: Text("Free Plan",style: TextStyle(color: Colors.white,fontSize: 15)),
                  //   onTap: (){},
                  // ),
                  UiHelper.customListTile("Email", Colors.white, 15),
                  // ListTile(
                  //   title: Text("Email",style: TextStyle(color: Colors.white,fontSize: 15)),
                  //   onTap: (){},
                  // )
                ],
              ),
              // UiHelper.expansionTile("Content Preference",Colors.white,20,"Allow Explicit content", Colors.white, 15,width: 75,isSwitched: isSwitched,callbackChange:() {_toggleSwitch(isSwitched);},),
              ExpansionTile(
                title: UiHelper.customText("Content Preference",
                    color: Colors.white, fontsize: 20),
                // Text("Content Preference",style: TextStyle(color: Colors.white,fontSize: 20)),
                childrenPadding: EdgeInsets.only(left: 40),
                children: [
                  ListTile(
                    title: Row(
                      children: [
                        UiHelper.customText("Allow Explicit content",
                            color: Colors.white, fontsize: 15),
                        // Text("Allow Explicit content",style: TextStyle(color: Colors.white,fontSize: 15)),
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
                // Text("Playback",style: TextStyle(color: Colors.white,fontSize: 20)),
                childrenPadding: EdgeInsets.only(left: 40),
                children: [
                  ListTile(
                    title: Row(
                      children: [
                        UiHelper.customText("Gapless",
                            color: Colors.white, fontsize: 15),
                        // Text("Gapless",style: TextStyle(color: Colors.white,fontSize: 15)),
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
                        // Text("Show unplayable songs",style: TextStyle(color: Colors.white,fontSize: 15)),
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
                        // Text("Canvas",style: TextStyle(color: Colors.white,fontSize: 15)),
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
                  // ListTile(
                  //   title: Text("App language",style: TextStyle(color: Colors.white,fontSize: 15)),
                  //   onTap: (){},
                  // ),
                  // ListTile(
                  //   title: Text("Language for music",style: TextStyle(color: Colors.white,fontSize: 15)),
                  //   onTap: (){},
                  // )
                  UiHelper.customListTile(
                      "Language for music", Colors.white, 15),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: UiHelper.customTextButton("About",
                    color: Colors.white, fontsize: 20),
                // TextButton(onPressed: (){}, child: Text("About",style: TextStyle(color: Colors.white,fontSize: 20),)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: UiHelper.customTextButton("Log out",
                    color: Colors.white, fontsize: 20, callback: () {
                      UiHelper.CustomAlertBox(context, "are you sure you want to logout?",alertbtn:"logout",navigateTo: Signin());
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
