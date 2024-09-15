import 'package:cloud_firestore/cloud_firestore.dart';

class AlbumModel{
  // final String id;
  late final String albumname;
  late final String photo;
  // late final List<String> songname;
  // AlbumModel({required this.name,required this.photo,required this.songname});
  AlbumModel({required this.albumname,required this.photo});
  factory AlbumModel.fromDocument(Map<dynamic, dynamic> json){
    // List <String>songnames;
    // if(json['songname'] is List){
    //   songnames = (json['songname'] as List<dynamic>).map((el)=> el as String).toList();
    // }else if(json['songname'] is String){
    //   songnames = [json['songname'] as String];
    // }else{
    //   songnames =[];
    // }
    return AlbumModel(
      albumname: json['AlbumName']??'',
      photo: json['image']??'',
      // songname:songnames
    );
  }
}