class ArtistModel {
  late final String artistname;
  late final String photo;
  late final List<String> albums;
  late final String desc;
  ArtistModel(
      {required this.artistname,
      required this.photo,
      required this.albums,
      required this.desc});
  factory ArtistModel.fromDocument(Map<dynamic, dynamic> json) {
    List<String> albums;
    if (json['AlbumName'] is List) {
      albums = (json['AlbumName'] as List<dynamic>)
          .map((el) => el as String)
          .toList();
    } else if (json['AlbumName'] is String) {
      albums = [json['AlbumName'] as String];
    } else {
      albums = [];
    }
    return ArtistModel(
      artistname: json['Artist Name'] ?? '',
      photo: json['Image'] ?? '',
      albums: albums,
      desc: json['Description'] ?? '',
    );
  }
}
