import 'package:ansicolor/ansicolor.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:plataforma_rede_campo/repositories/parse_errors.dart';
import 'package:plataforma_rede_campo/repositories/table_keys.dart';
import '../models/news.dart';

AnsiPen greenPen = AnsiPen()..green();

class NewsRepository {
  Future<List<News>> getAllNews({String? search, required int page}) async {
    try {
      //especificando que a busca sera na tabela 'keyNewsTable'
      final queryBuilder = QueryBuilder<ParseObject>(ParseObject(keyNewsTable));

      //dizemos para trazer na busca todos os dados do Field
      queryBuilder.includeObject([keyNewsField]);

      queryBuilder.setLimit(10);

      queryBuilder.setAmountToSkip(page * 10);

      if (search != null && search.trim().isNotEmpty) {
        queryBuilder.whereContains(keyNewsTitle, search, caseSensitive: false);
      }

      queryBuilder.whereEqualTo(keyNewsStatus, NewsStatus.ACTIVE.index);

      //ordena pela data de criacao 'do mais novo para o mais velho'
      queryBuilder.orderByDescending(keyNewsCreatedAt);

      final response = await queryBuilder.query();

      if (response.success && response.results != null) {
        if (kDebugMode) {
          print('Sucess ${response.results}');
        }
        //response contem uma lista de ParseObject então precisamos converter essa lista em uma lista de News
        return response.results!.map((e) => News.fromParse(e)).toList();
      } else if (response.success && response.results == null) {
        //se nao encontrar nenum resultado na busca retorna uma lista vazia
        return [];
      } else {
        return Future.error(ParseErrors.getDescription(response.error!.code));
      }
    } catch (e) {
      return Future.error('Falha de conexão');
    }
  }

  Future<int> getCountAllNews(String? search) async {
    final queryBuilder = QueryBuilder<ParseObject>(ParseObject(keyNewsTable));

    queryBuilder.whereEqualTo(keyNewsStatus, NewsStatus.ACTIVE.index);

    if (search != null && search.trim().isNotEmpty) {
      queryBuilder.whereContains(keyNewsTitle, search, caseSensitive: false);
    }

    final response = await queryBuilder.count();

    if (response.success && response.results != null) {
      if (kDebugMode) {
        print(greenPen('Sucess ${response.results!.first}'));
      }
      return response.results!.first;
    } else if (response.success && response.results == null) {
      return 0;
    } else {
      return Future.error(ParseErrors.getDescription(response.error!.code));
    }
  }

  Future<void> saveNews(News news) async {
    try {
      final parseUser = await ParseUser.currentUser() as ParseUser;

      //cria um objeto (registro da tabela News')
      final newsObject = ParseObject(keyNewsTable);

      //verifica se esta sendo editado uma news
      if (news.id != null) {
        newsObject.objectId = news.id;
      }

      final parseImage1 = await saveImage(news.image1!);

      final parseImage2 = await saveImage(news.image2!);

      //definir as permissões deste objeto(tabela)
      final parseAcl = ParseACL(owner: parseUser);
      parseAcl.setPublicReadAccess(allowed: true);
      parseAcl.setPublicWriteAccess(allowed: true);
      newsObject.setACL(parseAcl);

      //criando relacao entre o objeto News (tabela News) e o objeto Field (tabela Field)
      //newsObject.set<ParseObject>(keyNewsField, ParseObject(keyFieldTable)..set(keyFieldId, news.field!.id));

      //demais campos
      newsObject.set<String>(keyNewsTitle, news.title!);
      newsObject.set<ParseWebFile>(keyNewsImage1, parseImage1);
      newsObject.set<ParseWebFile>(keyNewsImage2, parseImage2);
      newsObject.set<String?>(keyNewsTitleImage2, news.titleImage2);
      newsObject.set<String>(keyNewsContent, news.content!);
      newsObject.set<String?>(keyNewsOptionalContent, news.optionalContent);

      final response = await newsObject.save();

      if (!response.success) {
        return Future.error(ParseErrors.getDescription(response.error!.code));
      }
    } catch (e) {
      return Future.error('Falha ao salvar News: ${e.toString()}');
    }
  }

  Future<ParseWebFile> saveImage(dynamic image) async {
    ParseWebFile parseImage;
    try {
      if (image is FilePickerResult) {
        if (kDebugMode) {
          print(greenPen('Imagem sem upload'));
        }
        final parseFile = ParseWebFile(image.files.first.bytes, name: 'image${DateTime.now().millisecondsSinceEpoch.toString()}.jpg');
        final response = await parseFile.save();
        parseImage = parseFile;
        if (!response.success) {
          return Future.error(ParseErrors.getDescription(response.error!.code));
        }
      } else {
        if (kDebugMode) {
          print(greenPen('Imagem com upload'));
          print(greenPen(image));
        }
        final parseFile = ParseWebFile(null, name: image.name, url: image.url);
        parseImage = parseFile;
      }
      return parseImage;
    } catch (e) {
      return Future.error('Falha ao salvar imagens ${e.toString()}');
    }
  }

  Future<void> delete(News news) async {
    final parseObject = ParseObject(keyNewsTable)..set(keyProjectId, news.id);

    //parseObject.set(keyAdStatus, AdStatus.DELETED.index);

    final response = await parseObject.save();
    if (!response.success) {
      return Future.error(ParseErrors.getDescription(response.error!.code));
    }
  }
}

/*Future<List<ParseWebFile>> saveImages(List images) async {
    final parseImages = <ParseWebFile>[];

    try {
      for (final image in images) {
        if (image is FilePickerResult) {
          if (kDebugMode) {
            print(greenPen('Imagem sem upload'));
          }
          final parseFile = ParseWebFile(image.files.first.bytes, name: 'image1.jpg');
          final response = await parseFile.save();
          if (!response.success) {
            return Future.error(ParseErrors.getDescription(response.error!.code));
          }
          parseImages.add(parseFile);
        } else {
          final parseFile = ParseWebFile(null, name: path.basename(image), url: image);
          //parseFile.name = path.basename(image);
          parseFile.url = image;
          parseImages.add(parseFile);
        }
      }
      return parseImages;
    } catch (e) {
      return Future.error('Falha ao salvar imagens ${e.toString()}');
    }
  }*/
