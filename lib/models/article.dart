import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:plataforma_rede_campo/repositories/table_keys.dart';

enum ArticleStatus { PENDING, ACTIVE, DELETED }

class Article {
  Article({this.id, this.title, this.summary, this.authors, this.publisher, this.publicationYear, this.doi, this.status});

  String? id;
  String? title;
  String? summary;
  String? authors;
  String? publisher;
  String? publicationYear;
  String? doi;
  ArticleStatus? status;

  Article.fromParse(ParseObject parseObject) {
    id = parseObject.objectId;
    title = parseObject.get<String>(keyArticleTitle);
    summary = parseObject.get<String>(keyArticleSummary);
    authors = parseObject.get<String>(keyArticleAuthors);
    publisher = parseObject.get<String>(keyArticlePublisher);
    publicationYear = parseObject.get<String>(keyArticlePublicationYear);
    doi = parseObject.get<String>(keyArticleDoi);
    status = ArticleStatus.values[parseObject.get<int>(keyArticleStatus)!];
  }

  @override
  String toString() {
    return 'Article{id: $id, title: $title, summary: $summary, authors: $authors, publisher: $publisher, publicationYear: $publicationYear, doi: $doi, status: $status}';
  }
}
