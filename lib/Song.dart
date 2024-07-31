import 'package:cloud_firestore/cloud_firestore.dart';

class Song{
  final String id;
  final String name;
  final String url;
  final String photo;
  Song({required this.id,required this.name,required this.url,required this.photo});
  factory Song.fromDocument(DocumentSnapshot doc){
    return Song(
      id:doc.id,
      name: doc['songname'],
      url:doc['link'],
      photo: doc['photo'],
    );
  }
}
Future<List<Song>> fetchSongs() async{
  final snapshot=await FirebaseFirestore.instance.collection('trial').get();
  return snapshot.docs.map((doc)=>Song.fromDocument(doc)).toList();
}