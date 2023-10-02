import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:plataforma_rede_campo/models/user.dart';
import 'package:plataforma_rede_campo/repositories/table_keys.dart';
import 'package:plataforma_rede_campo/repositories/user_repository.dart';

enum ProjectType { PESQUISA, EXTENSAO, INOVACAOETECNOLOGIA }

enum ProjectStatus { PENDING, ACTIVE, DELETED }

class Project {
  Project({
    this.id,
    this.title,
    this.content,
    this.participants,
    this.type = ProjectType.PESQUISA,
    this.status = ProjectStatus.ACTIVE,
    this.createdAt,
    this.updatedAt,
    this.autor,
  });

  String? id;
  String? title;
  String? content;
  String? participants;
  /*Autor autor;
  */
  late ProjectType type;
  ProjectStatus? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  User? autor;

  Project.fromParse(ParseObject parseObject) {
    id = parseObject.objectId;
    title = parseObject.get<String>(keyProjectTitle)!;
    content = parseObject.get<String>(keyProjectDescription)!;
    participants = parseObject.get<String>(keyProjectParticipants);
    type = ProjectType.values[parseObject.get(keyProjectType)];
    status = ProjectStatus.values[parseObject.get<int>(keyProjectStatus)!];
    createdAt = parseObject.createdAt;
    updatedAt = parseObject.updatedAt;
    autor = UserRepository().mapParseToUser(parseObject.get<ParseUser>(keyProjectOwner)!);
  }

  @override
  String toString() {
    return 'Project{id: $id, title: $title, content: $content, participants: $participants, type: $type, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, autor: $autor}';
  }
}
