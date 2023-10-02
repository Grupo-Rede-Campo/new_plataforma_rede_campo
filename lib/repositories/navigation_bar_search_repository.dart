import 'package:ansicolor/ansicolor.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:plataforma_rede_campo/models/book_chapter.dart';
import 'package:plataforma_rede_campo/models/project.dart';
import 'package:plataforma_rede_campo/repositories/parse_errors.dart';
import 'package:plataforma_rede_campo/repositories/table_keys.dart';

import '../models/article.dart';
import '../models/book.dart';

AnsiPen greenPen = AnsiPen()..green();

class NavigationBarSearchRepository {
  Future<List<Object>> searchAllItems({String? search /*, required int page*/}) async {
    try {
      List<Object> generallist = [];

      //especificando que a busca sera na tabela 'keyProjectTable'
      final projectQuery = QueryBuilder<ParseObject>(ParseObject(keyProjectTable));

      projectQuery.includeObject([keyProjectOwner]);

      //especificando o limite de itens retornados na consulta
      //projectQuery.setLimit(10);

      //Pula a quantidade int de resultados
      //projectQuery.setAmountToSkip(page * 10);

      if (search != null && search.trim().isNotEmpty) {
        projectQuery.whereContains(keyProjectTitle, search, caseSensitive: false);
      }

      //ordena pela data de criacao 'do mais novo para o mais velho'
      projectQuery.orderByAscending(keyProjectCreatedAt);

      final bookQuery = QueryBuilder<ParseObject>(ParseObject(keyBookTable));

      //especificando o limite de itens retornados na consulta
      //bookQuery.setLimit(10);

      //bookQuery.setAmountToSkip(page * 10);

      bookQuery.whereEqualTo(keyBookStatus, BookStatus.ACTIVE.index);

      if (search != null && search.trim().isNotEmpty) {
        bookQuery.whereContains(keyBookTitle, search, caseSensitive: false);
      }

      //ordena pela data de criacao 'do mais novo para o mais velho'
      bookQuery.orderByDescending(keyBookCreatedAt);

      final bookChapterQuery = QueryBuilder<ParseObject>(ParseObject(keyBookChapterTable));

      //especificando o limite de itens retornados na consulta
      //bookQuery.setLimit(10);

      //bookQuery.setAmountToSkip(page * 10);

      //bookChapterQuery.whereEqualTo(keyBookStatus, BookStatus.ACTIVE.index);

      if (search != null && search.trim().isNotEmpty) {
        bookChapterQuery.whereContains(keyBookChapterTitle, search, caseSensitive: false);
      }

      //ordena pela data de criacao 'do mais novo para o mais velho'
      bookChapterQuery.orderByDescending(keyBookChapterCreatedAt);

      final articleQuery = QueryBuilder<ParseObject>(ParseObject(keyArticleTable));

      //especificando o limite de itens retornados na consulta
      //bookQuery.setLimit(10);

      //bookQuery.setAmountToSkip(page * 10);

      //articleQuery.whereEqualTo(keyBookStatus, BookStatus.ACTIVE.index);

      if (search != null && search.trim().isNotEmpty) {
        articleQuery.whereContains(keyArticleTitle, search, caseSensitive: false);
      }

      //ordena pela data de criacao 'do mais novo para o mais velho'
      articleQuery.orderByDescending(keyArticleCreatedAt);

      final projectResponse = await projectQuery.query();
      final bookResponse = await bookQuery.query();
      final bookChapterRespponse = await bookChapterQuery.query();
      final articleRespponse = await articleQuery.query();

      if (projectResponse.success && projectResponse.results != null) {
        print(greenPen('Succes Project'));
        final projectList = projectResponse.results!.map((e) => Project.fromParse(e)).toList();
        print(greenPen(projectList));
        generallist.addAll(projectList);
      } else if (projectResponse.success && projectResponse.results == null) {
        print(greenPen('Project Vazio'));
        generallist.addAll([]);
      } else {
        print(greenPen(projectResponse.error!));
        return Future.error(ParseErrors.getDescription(projectResponse.error!.code));
      }

      if (bookResponse.success && bookResponse.results != null) {
        print(greenPen('Succes Book'));
        final bookList = bookResponse.results!.map((e) => Book.fromParse(e)).toList();
        print(greenPen(bookList));
        generallist.addAll(bookList);
      } else if (bookResponse.success && bookResponse.results == null) {
        print(greenPen('Book Vazio'));
        generallist.addAll([]);
      } else {
        print(greenPen(bookResponse.error!));
        return Future.error(ParseErrors.getDescription(bookResponse.error!.code));
      }

      if (bookChapterRespponse.success && bookChapterRespponse.results != null) {
        print(greenPen('Succes BookChapter'));
        final bookChapterList = bookChapterRespponse.results!.map((e) => BookChapter.fromParse(e)).toList();
        print(greenPen(bookChapterList));
        generallist.addAll(bookChapterList);
      } else if (bookChapterRespponse.success && bookChapterRespponse.results == null) {
        print(greenPen('Book Vazio'));
        generallist.addAll([]);
      } else {
        print(greenPen(bookChapterRespponse.error!));
        return Future.error(ParseErrors.getDescription(bookResponse.error!.code));
      }

      if (articleRespponse.success && articleRespponse.results != null) {
        print(greenPen('Succes Article'));
        final articleList = articleRespponse.results!.map((e) => Article.fromParse(e)).toList();
        print(greenPen(articleList));
        generallist.addAll(articleList);
      } else if (articleRespponse.success && articleRespponse.results == null) {
        print(greenPen('Article Vazio'));
        generallist.addAll([]);
      } else {
        print(greenPen(articleRespponse.error!));
        return Future.error(ParseErrors.getDescription(bookResponse.error!.code));
      }

      return generallist;
    } catch (e) {
      return Future.error('Falha de conexão');
    }
  }
}
