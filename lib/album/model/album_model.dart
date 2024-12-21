class AlbumModel {
  final String id;
  final String title;
  final String imageUrl;
  final String author;

  AlbumModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.author,
  });

  // Фабричный метод для создания объекта из JSON
  factory AlbumModel.fromJson(Map<String, dynamic> json) {
    return AlbumModel(
      id: json['mbid'] ?? '', // ID альбома (MusicBrainz ID)
      title: json['name'] ?? '', // Название альбома
      author: json['artist'] ?? '',
      imageUrl: (json['image'] as List<dynamic>?)
          ?.lastWhere(
            (img) => img['#text'] != null,
        orElse: () => {'#text': ''},
      )['#text'] ??
          '', // Ссылка на изображение (последний элемент в списке)
    );
  }

  // Метод для преобразования объекта в JSON
  Map<String, dynamic> toJson() {
    return {
      'mbid': id,
      'name': title,
      'artist': author,
      'image': [
        {'#text': imageUrl}
      ],
    };
  }
}
