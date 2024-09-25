class Song{
  final String songname;
  final String url;
  final String photo;
  final String artist;
  final String album;
  Song({required this.songname,required this.url,required this.photo,required this.artist,required this.album});
  factory Song.fromDocument(Map<dynamic, dynamic> json){
    return Song(
      songname: json['songname']??'',
      url:json['link']??'',
      photo: json['photo']??'',
      artist:json['artist']??'',
      album:json['album']??''
    );
  }
}