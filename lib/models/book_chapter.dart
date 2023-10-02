import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import '../repositories/table_keys.dart';

class BookChapter {
  BookChapter({
    this.id,
    this.title,
    this.authors,
    this.organizers,
    this.publisher,
    this.year,
    this.book,
    this.url,
    this.image,
  });

  String? id;
  String? title;
  String? authors;
  String? organizers;
  String? publisher;
  String? year;
  String? book;
  String? url;
  dynamic image;

  BookChapter.fromParse(ParseObject parseObject) {
    id = parseObject.objectId;
    title = parseObject.get<String>(keyBookChapterTitle);
    authors = parseObject.get<String>(keyBookChapterAuthors);
    organizers = parseObject.get<String>(keyBookChapterOrganizers);
    publisher = parseObject.get<String>(keyBookChapterPublisher);
    year = parseObject.get<String>(keyBookChapterYear);
    book = parseObject.get<String>(keyBookChapterBook);
    url = parseObject.get<String>(keyBookChapterUrl);
    image = parseObject.get(keyBookChapterImage);
  }

  @override
  String toString() {
    return 'BookChapter{id: $id, title: $title, authors: $authors, organizers: $organizers, publisher: $publisher, year: $year, book: $book, url: $url, image: $image}';
  }
}
