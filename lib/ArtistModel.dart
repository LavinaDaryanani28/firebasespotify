import 'package:cloud_firestore/cloud_firestore.dart';

class ArtistModel{
  // final String id;
  late final String artistname;
  late final String photo;
  late final String album;
  late final String desc;
  ArtistModel({required this.artistname,required this.photo,required this.album,required this.desc});
  factory ArtistModel.fromDocument(Map<dynamic, dynamic> json){
    return ArtistModel(
        artistname: json['Artist Name']??'',
        photo: json['Image']??'',
        album:json['Album Name']??'',
        desc:json['Description']??'',
    );
  }
}