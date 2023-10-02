import 'package:ansicolor/ansicolor.dart';
import 'package:flutter/foundation.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:plataforma_rede_campo/models/people_to_display.dart';
import 'package:plataforma_rede_campo/repositories/parse_errors.dart';
import 'package:plataforma_rede_campo/repositories/table_keys.dart';

AnsiPen greenPen = AnsiPen()..green();

class AboutRepository {
  Future<List<PeopleToDisplay>> getAllPesquisadores() async {
    try {
      //especificando que a busca sera na tabela 'PeopleToDisplay'
      final queryBuilder = QueryBuilder<ParseObject>(ParseObject(keyPeopleToDisplayTable));

      queryBuilder.whereEqualTo(keyPeopleToDisplayType, PeopleToDisplayType.PESQUISADOR.index);

      final response = await queryBuilder.query();

      if (response.success && response.results != null) {
        //response contem uma lista de ParseObject então precisamos converter essa lista em uma lista de PeopleToDisplay
        print(greenPen("Sucess ${response.results}"));
        return response.results!.map((e) => PeopleToDisplay.fromParse(e)).toList();
      } else if (response.success && response.results == null) {
        //se nao encontrar nenum resultado na busca retorna uma lista vazia
        return [];
      } else {
        return Future.error(ParseErrors.getDescription(response.error!.code));
      }
    } catch (e) {
      if (kDebugMode) {
        print(greenPen(e.toString()));
      }
      return Future.error(greenPen('Falha de conexão'));
    }
  }

  Future<List<PeopleToDisplay>> getAllMembros() async {
    try {
      //especificando que a busca sera na tabela 'PeopleToDisplay'
      final queryBuilder = QueryBuilder<ParseObject>(ParseObject(keyPeopleToDisplayTable));

      queryBuilder.whereEqualTo(keyPeopleToDisplayType, PeopleToDisplayType.MEMBRO.index);

      final response = await queryBuilder.query();

      if (response.success && response.results != null) {
        //response contem uma lista de ParseObject então precisamos converter essa lista em uma lista de PeopleToDisplay
        print(greenPen("Sucess ${response.results}"));
        return response.results!.map((e) => PeopleToDisplay.fromParse(e)).toList();
      } else if (response.success && response.results == null) {
        //se nao encontrar nenum resultado na busca retorna uma lista vazia
        return [];
      } else {
        return Future.error(ParseErrors.getDescription(response.error!.code));
      }
    } catch (e) {
      if (kDebugMode) {
        print(greenPen(e.toString()));
      }
      return Future.error(greenPen('Falha de conexão'));
    }
  }

  Future<List<PeopleToDisplay>> getAllColaboradores() async {
    try {
      //especificando que a busca sera na tabela 'PeopleToDisplay'
      final queryBuilder = QueryBuilder<ParseObject>(ParseObject(keyPeopleToDisplayTable));

      queryBuilder.whereEqualTo(keyPeopleToDisplayType, PeopleToDisplayType.COLABORADOR.index);

      final response = await queryBuilder.query();

      if (response.success && response.results != null) {
        //response contem uma lista de ParseObject então precisamos converter essa lista em uma lista de PeopleToDisplay
        return response.results!.map((e) => PeopleToDisplay.fromParse(e)).toList();
      } else if (response.success && response.results == null) {
        //se nao encontrar nenum resultado na busca retorna uma lista vazia
        return [];
      } else {
        return Future.error(ParseErrors.getDescription(response.error!.code));
      }
    } catch (e) {
      if (kDebugMode) {
        print(greenPen(e.toString()));
      }
      return Future.error(greenPen('Falha de conexão'));
    }
  }
}
