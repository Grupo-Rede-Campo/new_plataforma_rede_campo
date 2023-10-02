import 'package:ansicolor/ansicolor.dart';
import 'package:flutter/foundation.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:plataforma_rede_campo/models/book_chapter.dart';
import 'package:plataforma_rede_campo/repositories/parse_errors.dart';
import 'package:plataforma_rede_campo/repositories/table_keys.dart';

AnsiPen greenPen = AnsiPen()..green();

class BookChapterRepository {
  Future<List<BookChapter>> getAllBookChapters({String? search, required int page}) async {
    try {
      //especificando que a busca sera na tabela 'keyBookChapterTable'
      QueryBuilder queryBuilder = QueryBuilder<ParseObject>(ParseObject(keyBookChapterTable));

      //limite de itens retornados na consulta
      queryBuilder.setLimit(10);

      queryBuilder.setAmountToSkip(page * 10);

      if (search != null && search.trim().isNotEmpty) {
        queryBuilder.whereContains(keyBookChapterTitle, search, caseSensitive: false);
      }

      queryBuilder.orderByDescending(keyBookChapterCreatedAt);

      final response = await queryBuilder.query();

      if (response.success && response.results != null) {
        return response.results!.map((e) => BookChapter.fromParse(e)).toList();
      } else if (response.success && response.results == null) {
        return [];
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

  Future<int> getCountAllBookChapters({String? search}) async {
    try {
      QueryBuilder queryBuilder = QueryBuilder<ParseObject>(ParseObject(keyBookChapterTable));

      if (search != null && search.trim().isNotEmpty) {
        queryBuilder.whereContains(keyBookChapterTitle, search, caseSensitive: false);
      }

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
}
