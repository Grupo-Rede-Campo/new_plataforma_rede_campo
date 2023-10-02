import 'package:flutter/foundation.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:plataforma_rede_campo/models/project.dart';
import 'package:plataforma_rede_campo/repositories/parse_errors.dart';
import 'package:plataforma_rede_campo/repositories/table_keys.dart';
import 'package:ansicolor/ansicolor.dart';

AnsiPen greenPen = AnsiPen()..green();

class ProjectRepository {
  Future<List<Project>> getAllProject({required int page, int? itemsPerPage, String? search, ProjectType? projectType}) async {
    try {
      //especificando que a busca sera na tabela 'keyProjectTable'
      final queryBuilder = QueryBuilder<ParseObject>(ParseObject(keyProjectTable));

      queryBuilder.includeObject([keyProjectOwner]);

      if (projectType != null) {
        queryBuilder.whereEqualTo(keyProjectType, projectType.index);
      }

      queryBuilder.whereEqualTo(keyProjectStatus, ProjectStatus.ACTIVE.index);

      //especificando o limite de itens retornados na consulta
      queryBuilder.setLimit(itemsPerPage ?? 1);

      //Pula a quantidade int de resultados
      queryBuilder.setAmountToSkip(page * (itemsPerPage ?? 1));

      //ordena pela data de criacao 'do mais novo para o mais velho'
      queryBuilder.orderByDescending(keyProjectCreatedAt);

      final response = await queryBuilder.query();

      if (response.success && response.results != null) {
        //response contem uma lista de ParseObject então precisamos converter essa lista em uma lista de Project
        //print(greenPen(response.results!));
        return response.results!.map((e) => Project.fromParse(e)).toList();
      } else if (response.success && response.results == null) {
        return [];
      } else {
        return Future.error(ParseErrors.getDescription(response.error!.code));
      }
    } catch (e) {
      return Future.error('Falha de conexão');
    }
  }

  Future<int> getCountAllProjects({String? search, ProjectType? projectType}) async {
    try {
      //definindo que a busca sera na tabela 'keyProjectTable'
      final queryBuilder = QueryBuilder<ParseObject>(ParseObject(keyProjectTable));

      if (projectType != null) {
        queryBuilder.whereEqualTo(keyProjectType, projectType.index);
      }
      //se search for passado
      if (search != null && search.trim().isNotEmpty) {
        queryBuilder.whereContains(keyProjectTitle, search, caseSensitive: false);
      }

      queryBuilder.whereEqualTo(keyProjectStatus, ProjectStatus.ACTIVE.index);

      final response = await queryBuilder.count();

      if (response.success && response.results != null) {
        if (kDebugMode) {
          print(greenPen('Sucess: ${response.results!.first}'));
        }
        return response.results!.first;
      } else if (response.success && response.results == null) {
        return 0;
      } else {
        if (kDebugMode) {
          print(greenPen('Erro: ${ParseErrors.getDescription(response.error!.code)}'));
        }
        return Future.error(ParseErrors.getDescription(response.error!.code));
      }
    } catch (e) {
      return Future.error('Falha de conexão');
    }
  }

  Future<void> saveProject(Project project) async {
    try {
      //obtemos o usuario atual logado
      final parseUser = await ParseUser.currentUser() as ParseUser;

      final projectObject = ParseObject(keyProjectTable);

      //verifica se esta sendo editado uma news
      if (project.id != null) {
        projectObject.objectId = project.id;
      }

      //definir as permissões deste objeto(tabela)
      final parseAcl = ParseACL(owner: parseUser);
      parseAcl.setPublicReadAccess(allowed: true);
      parseAcl.setPublicWriteAccess(allowed: true);
      projectObject.setACL(parseAcl);

      projectObject.set<String>(keyProjectTitle, project.title!);
      projectObject.set<String>(keyProjectDescription, project.content!);
      projectObject.set<String>(keyProjectParticipants, project.participants!);
      projectObject.set<int>(keyProjectType, project.type.index);
      projectObject.set<int>(keyProjectStatus, project.status!.index);
      projectObject.set<ParseUser>(keyProjectOwner, parseUser);

      final response = await projectObject.save();

      if (!response.success) {
        return Future.error(ParseErrors.getDescription(response.error!.code));
      }
    } catch (e) {
      return Future.error('Falha ao salvar Project: ${e.toString()}');
    }
  }

  Future<void> delete({required Project project}) async {
    final parseObject = ParseObject(keyProjectTable)..set(keyProjectId, project.id);

    parseObject.set(keyProjectStatus, ProjectStatus.DELETED.index);

    final response = await parseObject.save();
    if (!response.success) {
      return Future.error(ParseErrors.getDescription(response.error!.code));
    }
  }
}
