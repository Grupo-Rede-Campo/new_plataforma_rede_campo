import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import '../repositories/table_keys.dart';

enum UserType { ADMINISTRADOR, PESQUISADOR }

class User {
  User({
    this.id,
    required this.name,
    required this.email,
    this.password,
    required this.phone,
    required this.type,
    this.image,
    this.isDisabled = false,
    this.createdAt,
  });

  String? id;
  late String name;
  late String email;
  String? password;
  late String phone;
  late UserType type;
  dynamic image;
  late bool isDisabled;
  DateTime? createdAt;

  User.fromParse(ParseUser parseUser) {
    id = parseUser.objectId!;
    name = parseUser.get<String>(keyUserName)!;
    email = parseUser.get<String>(keyUserEmail) ?? '';
    phone = parseUser.get<String>(keyUserPhone)!;
    type = UserType.values[parseUser.get(keyUserType)];
    image = parseUser.get(keyUserImage);
    isDisabled = parseUser.get<bool>(keyUserIsDisabled) ?? true;
    createdAt = parseUser.createdAt;
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "password": password,
        "phone": phone,
        "type": type.index,
      };

  @override
  String toString() {
    return 'User{id: $id, name: $name, email: $email, password: $password, phone: $phone, type: $type, image: $image, createdAt: $createdAt}';
  }
}
