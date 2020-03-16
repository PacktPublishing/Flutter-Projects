class Book {
  String id;
  String title;
  String authors;
  String description;
  String publisher;

Book(this.id, this.title, this.authors, this.description, this.publisher);



Map <String, dynamic> toJson() {
  return {
    'id': id,
    'title': title,
    'authors': authors,
    'description': description,
    'publisher': publisher
    };
}

factory Book.fromJson(Map<String, dynamic> parsedJson) {
    final String id =  parsedJson['id'];
    final String title = parsedJson['volumeInfo']['title'];
    String authors = (parsedJson['volumeInfo']['authors'] == null) ? '' : parsedJson['volumeInfo']['authors'].toString();
    authors = authors.replaceAll('[', '');
    authors = authors.replaceAll(']', '');
    final String description = (parsedJson['volumeInfo']['description']==null) ? '' : parsedJson['volumeInfo']['description'];
    final String publisher = (parsedJson['volumeInfo']['publisher'] == null) ? '': parsedJson['volumeInfo']['publisher'];
    return Book(
      id,
      title,
      authors,
      description,
      publisher,
    );
  }
}