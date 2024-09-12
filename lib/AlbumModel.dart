import 'package:cloud_firestore/cloud_firestore.dart';

class AlbumModel{
  // final String id;
  late final String name;
  late final String photo;
  late final String songname;
  AlbumModel({required this.name,required this.photo,required this.songname});
  factory AlbumModel.fromDocument(Map<dynamic, dynamic> json){
    return AlbumModel(
      name: json['AlbumName']??'',
      photo: json['image']??'',
      songname:json['songname']??''
    );
  }
}