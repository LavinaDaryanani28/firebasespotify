import 'package:cloud_firestore/cloud_firestore.dart';

class Song{
  // final String id;
  final String songname;
  final String url;
  final String photo;
  final String artist;
  final String album;
  Song({required this.songname,required this.url,required this.photo,required this.artist,required this.album});
  factory Song.fromDocument(Map<dynamic, dynamic> json){
    return Song(
      // id:json['id'],
      songname: json['songname']??'',
      url:json['link']??'',
      photo: json['photo']??'',
      artist:json['artist']??'',
      album:json['album']??''
    );
  }
}
// Future<List<Song>> fetchSongs() async{
//   final snapshot=await FirebaseFirestore.instance.collection('trial').get();
//   return snapshot.docs.map((doc)=>Song.fromDocument(doc)).toList();
// }

// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class Song{
//   final String id;
//   final String name;
//   final String url;
//   final String photo;
//   final String artist;
//   Song({required this.id,required this.name,required this.url,required this.photo,required this.artist});
//   factory Song.fromDocument(DocumentSnapshot doc){
//     return Song(
//         id:doc.id,
//         name: doc['songname'],
//         url:doc['link'],
//         photo: doc['photo'],
//         artist:doc['artist']
//     );
//   }
// }
// Future<List<Song>> fetchSongs() async{
//   final snapshot=await FirebaseFirestore.instance.collection('trial').get();
//   return snapshot.docs.map((doc)=>Song.fromDocument(doc)).toList();
// }