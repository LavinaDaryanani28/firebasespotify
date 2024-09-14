import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:spotifyfirebase/uihelper.dart';

import 'albums.dart';
import 'artist.dart';
import 'librarycontroller.dart';


class Library extends StatefulWidget {
  const Library({super.key});

  @override
  State<Library> createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  @override
  Widget build(BuildContext context) {
    return
      GetBuilder(
          init: LibraryController(),
          builder: (controller) {
            return Scaffold(
              appBar: AppBar(
                toolbarHeight: 130,
                backgroundColor: Colors.black,
                flexibleSpace: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(top:20,left: 16,right: 16),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            UiHelper.customText("Your Library",
                                color: Colors.white,
                                fontsize: 25,
                                fontweight: FontWeight.bold),
                            // SizedBox(
                            //   width: 100,
                            // ),
                            Spacer(),
                            Row(
                              children: [
                                UiHelper.iconBtn(
                                    icondata: Icons.search, 35, color: Colors.white),
                                IconButton(
                                  icon: Icon(Icons.add,color: Colors.white,size: 35,),
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
                                                    child: UiHelper.customButton("Create",
                                                        bgcolor: Colors.black,
                                                        forecolor:
                                                        Colors.white.withOpacity(0.9),
                                                        fontsize: 20,
                                                        borderradius: 10, callback: () {
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
                        SizedBox(height: 10,),
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
                                sidecolor: Colors.white,callback: (){Navigator.push(context,MaterialPageRoute(builder: (context)=>Artist(artistname: artistName,)));}),
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
                                sidecolor: Colors.white,callback: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>Artist(artistname: artistName,)));}),
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
                                sidecolor: Colors.white,callback: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>Album()));}),
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
                            fontsize: 18),
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
                              UiHelper.customTextButton(controller
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

    //   Scaffold(
    //   body:
    //   Padding(
    //     padding: const EdgeInsets.symmetric(vertical: 60,horizontal: 20),
    //     child: Column(children: [
    //       Row(
    //         children: [
    //           // CircleAvatar(child: Image.network("https://cdni.iconscout.com/illustration/premium/thumb/woman-profile-8187680-6590622.png?f=webp",fit: BoxFit.cover,),radius: 25,),
    //           // SizedBox(width: 20,),
    //           UiHelper.customText("Your Library",color: Colors.white,fontsize: 25,fontweight: FontWeight.bold),
    //           // Text("Your Library",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
    //           SizedBox(width: 70,),
    //           UiHelper.iconBtn(icondata:Icons.search, 35, color:Colors.white),
    //           // IconButton(
    //           //   onPressed: () {},
    //           //   icon: const Icon(Icons.search,color: Colors.white,),
    //           //   iconSize: 35,
    //           // ),
    //           // SizedBox(width: 10,),
    //           IconButton(
    //             onPressed: (){
    //               showDialog(context: context, builder: (context){
    //                 return AlertDialog(
    //                   backgroundColor: Colors.white.withOpacity(0.9),
    //                   title: Text("Create Playlist"),
    //                   content: Container(
    //                     height: 150,
    //                     child: Column(
    //                       children: [
    //                         TextField(
    //                           controller:playlist,
    //                           decoration: InputDecoration(
    //                             labelText: "Create your own playlist",
    //                           ),
    //                         ),
    //                         SizedBox(height: 20,),
    //                         SizedBox(height: 50,child: UiHelper.customButton("Create",bgcolor:Colors.black,forecolor: Colors.white.withOpacity(0.9),fontsize: 20,borderradius: 10,callback: (){
    //                           // UiHelper.CustomAlertBox(context, "Are you sure you want to create your own playlist?",alertbtn:"createPlaylist",callback: () {
    //                           addDynamic();
    //                           // LibraryController.addDynamic(listDynamic:listDynamic,
    //                           //     context:context,
    //                           //     playlist:playlist,
    //                           //     arrContent:arrContent);
    //                         // }
    //                         // );
    //                         }),),
    //
    //                       ],
    //                     ),
    //                   ),
    //                 );
    //               },);
    //             },
    //             // {showModalBottomSheet<void>(context: context, builder: (BuildContext context) {
    //             //   return Container(
    //             //       height: 250,
    //             //       decoration: BoxDecoration(
    //             //         borderRadius: BorderRadius.only(
    //             //           topLeft: Radius.circular(16.0),
    //             //           topRight: Radius.circular(16.0),
    //             //         ),
    //             //         color: Color(0xff232f34),
    //             //       ),
    //             //       child: Padding(
    //             //         padding: const EdgeInsets.all(8.0),
    //             //         child: Column(
    //             //           children: [
    //             //             UiHelper.customText("Create playlist",color: Colors.white,fontsize: 30),
    //             //             // Text("Create playlist",style: TextStyle(color: Colors.white,fontSize: 30),),
    //             //             SizedBox(height: 30,),
    //             //             TextField(
    //             //               controller: playlist,
    //             //               style: TextStyle(color: Colors.white),
    //             //               decoration: InputDecoration(
    //             //               labelText: "Enter your playlist name",
    //             //                 labelStyle: TextStyle(
    //             //                   color: Colors.white,
    //             //                   fontSize: 10,
    //             //                 ),
    //             //                 focusColor: Colors.white,
    //             //                 border: OutlineInputBorder(
    //             //                   borderRadius: BorderRadius.circular(10),
    //             //                 ),
    //             //             ),
    //             //
    //             //             ),
    //             //             SizedBox(height: 30,),
    //             //         UiHelper.customButton("Create",fontsize:  18, borderradius: 20, bgcolor:Colors.white, forecolor:Colors.black,callback:(){ addDynamic();
    //             //           // LibraryController.addDynamic(listDynamic:listDynamic,context:context,playlist:playlist,arrContent:arrContent);
    //             //         }),
    //             //             // ElevatedButton(onPressed:(){ addDynamic(); } , child: Text("Create",style: TextStyle(fontSize: 18),),
    //             //             //   style: ElevatedButton.styleFrom( shape: RoundedRectangleBorder(
    //             //             //       borderRadius: BorderRadius.circular(20)
    //             //             //   ),backgroundColor: Colors.white,foregroundColor: Colors.black),),
    //             //           ],
    //             //         ),
    //             //       ),
    //             //   );
    //             // });},
    //             icon: const Icon(Icons.add,color: Colors.white,),
    //             iconSize: 35,
    //           ),
    //         ],
    //       ),
    //       SizedBox(height: 20,),
    //       Row(
    //         children: [
    //           UiHelper.customButton("Playlist",fontsize:  15, fontweight:FontWeight.bold, borderradius: 25, bgcolor:Colors.transparent, forecolor:Colors.white,side: 1.0,sidecolor: Colors.white),
    //           // ElevatedButton(onPressed:(){} , child: Text("Playlist",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
    //           //   style: ElevatedButton.styleFrom( shape: RoundedRectangleBorder(
    //           //       borderRadius: BorderRadius.circular(25),side: BorderSide(width: 1.0, color: Colors.white),
    //           //   ),backgroundColor: Colors.transparent,foregroundColor: Colors.white),),
    //           SizedBox(width: 10,),
    //           UiHelper.customButton("Artist",fontsize:  15, fontweight:FontWeight.bold, borderradius: 25, bgcolor:Colors.transparent, forecolor:Colors.white,side: 1.0,sidecolor: Colors.white),
    //           // ElevatedButton(onPressed:(){} , child: Text("Artist",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
    //           //   style: ElevatedButton.styleFrom( shape: RoundedRectangleBorder(
    //           //     borderRadius: BorderRadius.circular(25),side: BorderSide(width: 1.0, color: Colors.white),
    //           //   ),backgroundColor: Colors.transparent,foregroundColor: Colors.white),),
    //           SizedBox(width: 10,),
    //           UiHelper.customButton("Albums",fontsize:  15, fontweight:FontWeight.bold, borderradius: 25, bgcolor:Colors.transparent, forecolor:Colors.white,side: 1.0,sidecolor: Colors.white),
    //           // ElevatedButton(onPressed:(){} , child: Text("Albums",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
    //           //   style: ElevatedButton.styleFrom( shape: RoundedRectangleBorder(
    //           //     borderRadius: BorderRadius.circular(25),side: BorderSide(width: 1.0, color: Colors.white),
    //           //   ),backgroundColor: Colors.transparent,foregroundColor: Colors.white),),
    //         ],
    //       ),
    //       SizedBox(height: 20,),
    //       Row(
    //         children: [
    //           UiHelper.customText("Recently Played",color: Colors.white,fontsize: 18),
    //           // Text("Recently Played",style: TextStyle(color: Colors.white,fontSize: 18),),
    //           SizedBox(width: 140,),
    //           UiHelper.iconBtn(icondata:Icons.grid_view_outlined, 25, color:Colors.white),
    //           // IconButton(
    //           //   onPressed: () {},
    //           //   icon: const Icon(Icons.grid_view_outlined,color: Colors.white,),
    //           //   iconSize: 25,
    //           // ),
    //         ],
    //       ),
    //       SizedBox(height: 10,),
    //       Row(
    //         children: [
    //           UiHelper.iconBtn( 30, color:Colors.white,image: true,imagePath: "https://i1.sndcdn.com/artworks-y6qitUuZoS6y8LQo-5s2pPA-t500x500.jpg",height: 70,width:70),
    //         // IconButton(
    //         // onPressed: () {},
    //         // icon:
    //         // Image.network("https://i1.sndcdn.com/artworks-y6qitUuZoS6y8LQo-5s2pPA-t500x500.jpg",height: 70,width:70,),
    //         //   iconSize: 30,
    //         // ),
    //
    //           UiHelper.customTextButton("Liked Songs",color: Colors.white,fontweight: FontWeight.bold,fontsize: 18),
    //           // TextButton(onPressed: (){}, child: Text("Liked Songs",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),)),
    //         ],
    //       ),
    //       Flexible(child: ListView.builder(
    //         itemCount:listDynamic.length,
    //           itemBuilder: (_,index)=>listDynamic[index]
    //       )),
    //       // Row(
    //       //   mainAxisAlignment: MainAxisAlignment.center,
    //       //   children: [
    //       //     IconButton(onPressed: (){
    //       //       Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
    //       //     }, icon: Column(
    //       //       children: [
    //       //         Icon(Icons.home,color: Colors.grey,),
    //       //         UiHelper.customText("Home", Colors.grey, 10),
    //       //       ],
    //       //     ),iconSize: 40,),
    //       //     SizedBox(width: 35,),
    //       //     IconButton(onPressed: (){
    //       //       Navigator.push(context, MaterialPageRoute(builder: (context)=>Library()));
    //       //     }, icon: Column(
    //       //       children: [
    //       //         Icon(Icons.library_music_outlined,color: Colors.grey,),
    //       //         UiHelper.customText("Library", Colors.grey, 10),
    //       //       ],
    //       //     ),iconSize: 40),
    //       //     SizedBox(width: 35,),
    //       //     IconButton(onPressed: (){
    //       //       // Navigator.push(context, MaterialPageRoute(builder: (context)=>));
    //       //     }, icon: Column(
    //       //       children: [
    //       //         Icon(Icons.person,color: Colors.grey,),
    //       //         UiHelper.customText("Profile", Colors.grey, 10),
    //       //       ],
    //       //     ),iconSize: 40),
    //       //   ],
    //       // ),
    //     ],),
    //   ),
    //       backgroundColor: Colors.black,
    // );
  }
}
// class DynamicWidget extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child:
//         Row(
//           children: [
//             UiHelper.iconBtn( 30, color:Colors.white,image: true,imagePath: "https://i1.sndcdn.com/artworks-y6qitUuZoS6y8LQo-5s2pPA-t500x500.jpg",height: 70,width:70),
//             // IconButton(
//             //   onPressed: () { },
//             //   icon:
//             //   Image.network("https://i1.sndcdn.com/artworks-y6qitUuZoS6y8LQo-5s2pPA-t500x500.jpg",height: 70,width:70,),
//             //   iconSize: 30,
//             // ),
//             UiHelper.customTextButton(arrContent[0]["name"].toString(),color: Colors.white,fontweight: FontWeight.bold,fontsize: 18),
//             // TextButton(onPressed: (){}, child: Text(arrContent[0]["name"].toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),)),
//             UiHelper.iconBtn(icondata:Icons.delete, 30),
//             // IconButton(
//             //   onPressed: () {
//             //
//             //   },
//             //   icon:Icon(Icons.delete),
//             //   iconSize: 30,
//             // ),
//           ],
//         ),
//     );
//   }
//
// }