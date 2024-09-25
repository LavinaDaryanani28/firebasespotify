import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'librarymodel.dart';

class LibraryController extends GetxController {
  Rx<List<AddPlaylist>> playlists = Rx<List<AddPlaylist>>([]);
  TextEditingController playlistTextEditingController = TextEditingController();
  late AddPlaylist playlist;
  var itemCount = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    playlistTextEditingController.dispose();
  }

  addDynamic(String name,BuildContext context) {
    playlist = AddPlaylist(playlistname: name,);
    playlists.value.add(playlist);
    itemCount.value = playlists.value.length;
    playlistTextEditingController.clear();
    Navigator.of(context).pop();
  }

  removeDynamic(int index) {
    playlists.value.removeAt(index);
    itemCount.value = playlists.value.length;
  }
}