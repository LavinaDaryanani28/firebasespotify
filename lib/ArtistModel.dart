class ArtistModel {
  final artistname;
  final albumname;
  final description;
  final image;
  ArtistModel(
      {required this.artistname,
      required this.albumname,
      required this.description,
      required this.image});
  factory ArtistModel.fromDocument(Map<dynamic, dynamic> json) {
    return ArtistModel(
        artistname: json['Album Name'] ?? '',
        albumname: json['Artist Name'] ?? '',
        description: json['Description'] ?? '',
        image: json['Image'] ?? '');
  }
}
