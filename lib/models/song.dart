class Song {
  final int? id;
  final String number;
  final String title;
  final String language;
  final String lyrics;

  Song({
    this.id,
    required this.number,
    required this.title,
    required this.language,
    required this.lyrics,
  });

  factory Song.fromMap(Map<String, dynamic> json) => Song(
        id: json['id'],
        number: json['number'],
        title: json['title'],
        language: json['language'],
        lyrics: json['lyrics'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'number': number,
        'title': title,
        'language': language,
        'lyrics': lyrics,
      };
}
