class DBBook {
  final int? id;
  final String title;
  final String authors;
  final String image;
  final String description;
  final String library;

  DBBook({
    this.id,
    required this.title,
    required this.authors,
    required this.image,
    required this.description,
    required this.library,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'authors': authors,
      'image': image,
      'description': description,
      'library': library,
    };
  }
}
