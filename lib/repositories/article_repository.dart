import 'package:ansicolor/ansicolor.dart';
import 'package:flutter/foundation.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:plataforma_rede_campo/models/article.dart';
import 'package:plataforma_rede_campo/repositories/parse_errors.dart';
import 'package:plataforma_rede_campo/repositories/table_keys.dart';

AnsiPen greenPen = AnsiPen()..green();

class ArticleRepository {
  Future<List<Article>> getAllArticles({String? search, required int page}) async {
    try {
      //especificando que a busca sera na tabela 'keyArticleTable'
      final queryBuilder = QueryBuilder<ParseObject>(ParseObject(keyArticleTable));

      //especificando o limite de itens retornados na consulta
      queryBuilder.setLimit(10);

      //Pula a quantidade int de resultados
      queryBuilder.setAmountToSkip(page * 10);

      //se search for passado
      if (search != null && search.trim().isNotEmpty) {
        queryBuilder.whereContains(keyArticleTitle, search, caseSensitive: false);
      }

      //ordena pela data de criacao 'do mais novo para o mais velho'
      queryBuilder.orderByDescending(keyArticleCreatedAt);

      final response = await queryBuilder.query();

      if (response.success && response.results != null) {
        return response.results!.map((e) => Article.fromParse(e)).toList();
      } else if (response.success && response.results == null) {
        return [];
      } else {
        return Future.error(ParseErrors.getDescription(response.error!.code));
      }
    } catch (e) {
      return Future.error('Falha de conexão');
    }
  }

  Future<int> getCountAllArticles(String? search) async {
    try {
      //definindo que a busca sera na tabela 'keyArticleTable'
      final queryBuilder = QueryBuilder<ParseObject>(ParseObject(keyArticleTable));

      //se search for passado
      if (search != null && search.trim().isNotEmpty) {
        queryBuilder.whereContains(keyArticleTitle, search, caseSensitive: false);
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

  Future<void> saveArticle(Article article) async {
    try {
      //indica que o ParseObject sera salvo (registro na tabela Article')
      final parseObject = ParseObject(keyArticleTable);

      //verifica se esta sendo editado um article
      if (article.id != null) {
        parseObject.objectId = article.id;
      }

      //definir as permissões deste objeto(tabela)
      final parseAcl = ParseACL(/*owner: parseUser*/);
      parseAcl.setPublicReadAccess(allowed: true);
      parseAcl.setPublicWriteAccess(allowed: true);
      parseObject.setACL(parseAcl);

      parseObject.set<String>(keyArticleTitle, article.title!);
      parseObject.set<String>(keyArticleSummary, article.summary!);
      parseObject.set<String>(keyArticleAuthors, article.authors!);
      parseObject.set<String>(keyArticlePublisher, article.publisher!);
      parseObject.set<String>(keyArticlePublicationYear, article.publicationYear!);
      parseObject.set<String>(keyArticleDoi, article.doi!);

      final response = await parseObject.save();

      if (!response.success) {
        return Future.error(ParseErrors.getDescription(response.error!.code));
      }
    } catch (e) {
      return Future.error("Falha ao salvar artigo ${e.toString()}");
    }
  }

  Future<void> delete({required Article article}) async {
    final parseObject = ParseObject(keyArticleTable)..set(keyArticleId, article.id);

    parseObject.set(keyBookStatus, ArticleStatus.DELETED.index);

    final response = await parseObject.save();
    if (!response.success) {
      return Future.error(ParseErrors.getDescription(response.error!.code));
    }
  }
}
