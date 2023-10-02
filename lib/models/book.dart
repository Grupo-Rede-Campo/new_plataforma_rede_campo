import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:plataforma_rede_campo/repositories/table_keys.dart';

enum BookStatus { PENDING, ACTIVE, DELETED }

class Book {
  Book({
    this.id,
    this.title,
    this.publisher,
    this.authors,
    this.year,
    this.url,
    this.status,
    this.image,
  });

  String? id;
  String? title;
  String? publisher;
  String? authors;
  String? year;
  String? url;
  BookStatus? status;
  dynamic image;

  Book.fromParse(ParseObject parseObject) {
    id = parseObject.objectId;
    title = parseObject.get<String>(keyBookTitle);
    publisher = parseObject.get<String>(keyBookPublisher);
    authors = parseObject.get<String>(keyBookAuthors);
    year = parseObject.get<String>(keyBookYear);
    url = parseObject.get<String>(keyBookURL);
    status = BookStatus.values[parseObject.get<int>(keyBookStatus)!];
    image = parseObject.get(keyBookImage)..url;
  }

  @override
  String toString() {
    return 'Book{id: $id, title: $title, publishing: $publisher, authors: $authors, year: $year, url: $url, image: $image}';
  }
}
