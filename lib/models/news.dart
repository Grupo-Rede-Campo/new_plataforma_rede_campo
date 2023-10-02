import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:plataforma_rede_campo/models/field.dart';
import '../repositories/table_keys.dart';

enum NewsStatus { ACTIVE, DELETED }

class News {
  News({
    this.id,
    this.title,
    this.titleImage2,
    this.content,
    this.optionalContent,
    this.field,
    this.image1,
    this.image2,
    this.status = NewsStatus.ACTIVE,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? title;
  String? titleImage2;
  String? content;
  String? optionalContent;
  Field? field;
  dynamic image1;
  dynamic image2;
  NewsStatus? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  News.fromParse(ParseObject parseObject) {
    id = parseObject.objectId;
    title = parseObject.get<String>(keyNewsTitle)!;
    image1 = parseObject.get(keyNewsImage1)..url;
    image2 = parseObject.get(keyNewsImage2)..url;
    titleImage2 = parseObject.get<String?>(keyNewsTitleImage2);
    content = parseObject.get<String>(keyNewsContent)!;
    optionalContent = parseObject.get<String?>(keyNewsOptionalContent);
    field = Field.fromParse(parseObject.get<ParseObject>(keyNewsField)!);
    status = NewsStatus.values[parseObject.get<int>(keyNewsStatus)!];
    createdAt = parseObject.createdAt;
    updatedAt = parseObject.updatedAt;
  }

  @override
  String toString() {
    return 'News{id: $id, title: $title, titleImage2: $titleImage2, content: $content, optionalContent: $optionalContent, field: $field, image1: $image1, image2: $image2, status: $status, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
