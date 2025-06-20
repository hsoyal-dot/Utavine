class SpotifySong {
  final String id;
  final String name;
  final String artists;
  final String albumImage;
  final String? previewUrl;

  SpotifySong({
    required this.id,
    required this.name,
    required this.artists,
    required this.albumImage,
    this.previewUrl,
  });

  factory SpotifySong.fromJson(Map<String, dynamic> json) {
    return SpotifySong(
      id: json['id'],
      name: json['name'],
      artists: json['artists'],
      albumImage: json['albumImage'],
      previewUrl: json['previewUrl'],
    );
  }
}