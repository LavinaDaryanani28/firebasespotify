import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:spotifyfirebase/LikedSongs.dart';
import 'package:spotifyfirebase/uihelper.dart';
import 'librarycontroller.dart';

class Library extends StatefulWidget {
  const Library({super.key});

  @override
  State<Library> createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: LibraryController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 130,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.black,
              flexibleSpace: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 16, right: 16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          UiHelper.customText("Your Library",
                              color: Colors.white,
                              fontsize: 25,
                              fontweight: FontWeight.bold),
                          Spacer(),
                          Row(
                            children: [
                              UiHelper.iconBtn(
                                  icondata: Icons.search,
                                  35,
                                  color: Colors.white),
                              IconButton(
                                icon: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 35,
                                ),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          backgroundColor:
                                              Colors.white.withOpacity(0.9),
                                          title: Text("Create Playlist"),
                                          content: Container(
                                            height: 150.h,
                                            child: Column(
                                              children: [
                                                TextField(
                                                  controller: controller
                                                      .playlistTextEditingController,
                                                  decoration: InputDecoration(
                                                    labelText:
                                                        "Create your own playlist",
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20.h,
                                                ),
                                                SizedBox(
                                                  height: 50.h,
                                                  child: UiHelper.customButton(
                                                      "Create",
                                                      bgcolor: Colors.black,
                                                      forecolor: Colors.white
                                                          .withOpacity(0.9),
                                                      fontsize: 20,
                                                      borderradius: 10,
                                                      callback: () {
                                                    controller.addDynamic(
                                                        controller
                                                            .playlistTextEditingController
                                                            .text,
                                                        context);
                                                  }),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          UiHelper.customButton("Playlist",
                              height: 35.h,
                              width: 90.w,
                              fontsize: 12,
                              fontweight: FontWeight.bold,
                              borderradius: 25,
                              bgcolor: Colors.transparent,
                              forecolor: Colors.white,
                              side: 1.0,
                              sidecolor: Colors.white,
                              callback: () {}),
                          SizedBox(
                            width: 10.w,
                          ),
                          UiHelper.customButton("Artist",
                              height: 35.h,
                              width: 80.w,
                              fontsize: 12,
                              fontweight: FontWeight.bold,
                              borderradius: 25,
                              bgcolor: Colors.transparent,
                              forecolor: Colors.white,
                              side: 1.0,
                              sidecolor: Colors.white,
                              callback: () {}),
                          SizedBox(
                            width: 10.w,
                          ),
                          UiHelper.customButton("Albums",
                              height: 35.h,
                              width: 90.w,
                              fontsize: 12,
                              fontweight: FontWeight.bold,
                              borderradius: 25,
                              bgcolor: Colors.transparent,
                              forecolor: Colors.white,
                              side: 1.0,
                              sidecolor: Colors.white,
                              callback: () {}),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      UiHelper.customText("Recently Played",
                          color: Colors.white, fontsize: 18),
                      Spacer(),
                      UiHelper.iconBtn(
                          icondata: Icons.grid_view_outlined,
                          25,
                          color: Colors.white),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      UiHelper.iconBtn(30,
                          color: Colors.white,
                          image: true,
                          imagePath:
                              "https://i1.sndcdn.com/artworks-y6qitUuZoS6y8LQo-5s2pPA-t500x500.jpg",
                          height: 70.h,
                          width: 70.w),
                      UiHelper.customTextButton("Liked Songs",
                          color: Colors.white,
                          fontweight: FontWeight.bold,
                          fontsize: 18, callback: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LikedSongs()));
                      }),
                    ],
                  ),
                  Expanded(
                    child: Obx(() => ListView.builder(
                          itemCount: controller.itemCount.value,
                          itemBuilder: ((context, index) {
                            return Row(
                              children: [
                                UiHelper.iconBtn(30,
                                    color: Colors.white,
                                    image: true,
                                    imagePath:
                                        "https://i1.sndcdn.com/artworks-y6qitUuZoS6y8LQo-5s2pPA-t500x500.jpg",
                                    height: 70.h,
                                    width: 70.w),
                                UiHelper.customTextButton(
                                    controller
                                        .playlists.value[index].playlistname!,
                                    color: Colors.white,
                                    fontweight: FontWeight.bold,
                                    fontsize: 18),
                                Spacer(),
                                GestureDetector(
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                  onTap: () {
                                    controller.removeDynamic(index);
                                  },
                                ),
                              ],
                            );
                          }),
                        )),
                  )
                ],
              ),
            ),
            backgroundColor: Colors.black,
          );
        });
  }
}