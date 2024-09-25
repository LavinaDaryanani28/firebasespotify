class AlbumModel{
  late final String albumname;
  late final String photo;

  AlbumModel({required this.albumname,required this.photo});
  factory AlbumModel.fromDocument(Map<dynamic, dynamic> json){

    return AlbumModel(
      albumname: json['AlbumName']??'',
      photo: json['image']??'',
    );
  }
}