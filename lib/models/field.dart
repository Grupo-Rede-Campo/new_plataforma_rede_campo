import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:plataforma_rede_campo/repositories/table_keys.dart';

class Field {
  Field({
    this.id,
    required this.areaCnpq,
    required this.description,
  });

  String? id;
  late String areaCnpq;
  late String description;

  Field.fromParse(ParseObject parseObject) {
    id = parseObject.objectId;
    areaCnpq = parseObject.get<String>(keyFieldAreaCnpq)!;
    description = parseObject.get<String>(keyFieldDescription)!;
  }

  @override
  String toString() {
    return 'Field{id: $id, areaCnpq: $areaCnpq, description: $description}';
  }
}
