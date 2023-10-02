import 'package:ansicolor/ansicolor.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:plataforma_rede_campo/models/book.dart';
import 'package:plataforma_rede_campo/repositories/parse_errors.dart';
import 'package:plataforma_rede_campo/repositories/table_keys.dart';

AnsiPen greenPen = AnsiPen()..green();

class BookRepository {
  Future<List<Book>> getAllBooks({String? search, required int page}) async {
    try {
      //especificando que a busca sera na tabela 'keyBookTable'
      final queryBuilder = QueryBuilder<ParseObject>(ParseObject(keyBookTable));

      //especificando o limite de itens retornados na consulta
      queryBuilder.setLimit(10);

      queryBuilder.setAmountToSkip(page * 10);

      queryBuilder.whereEqualTo(keyBookStatus, BookStatus.ACTIVE.index);

      if (search != null && search.trim().isNotEmpty) {
        queryBuilder.whereContains(keyBookTitle, search, caseSensitive: false);
      }

      //ordena pela data de criacao 'do mais novo para o mais velho'
      queryBuilder.orderByDescending(keyBookCreatedAt);

      final response = await queryBuilder.query();

      if (response.success && response.results != null) {
        return response.results!.map((e) => Book.fromParse(e)).toList();
      } else if (response.success && response.results == null) {
        return [];
      } else {
        return Future.error(ParseErrors.getDescription(response.error!.code));
      }
    } catch (e) {
      return Future.error('Falha de conexão');
    }
  }

  Future<int> getCountAllBooks(String? search) async {
    try {
      //definindo que a busca sera na tabela 'keyBookTable'
      final queryBuilder = QueryBuilder<ParseObject>(ParseObject(keyBookTable));

      queryBuilder.whereEqualTo(keyBookStatus, BookStatus.ACTIVE.index);

      //pesquisa para ver se String contém outra string
      if (search != null && search.trim().isNotEmpty) {
        queryBuilder.whereContains(keyBookTitle, search, caseSensitive: false);
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

  Future<void> saveBook(Book book) async {
    try {
      //indica que o ParseObject sera salvo (registro na tabela Book')
      final parseObject = ParseObject(keyBookTable);

      //verifica se esta sendo editado um book
      if (book.id != null) {
        parseObject.objectId = book.id;
      }

      final image = await saveImage(book.image);

      //definir as permissões deste objeto(tabela)
      final parseAcl = ParseACL(/*owner: parseUser*/);
      parseAcl.setPublicReadAccess(allowed: true);
      parseAcl.setPublicWriteAccess(allowed: true);
      parseObject.setACL(parseAcl);

      parseObject.set(keyBookImage, image);
      parseObject.set<String>(keyBookTitle, book.title!);
      parseObject.set<String>(keyBookPublisher, book.publisher!);
      parseObject.set<String>(keyBookAuthors, book.authors!);
      parseObject.set<String>(keyBookYear, book.year!);
      parseObject.set<String>(keyBookURL, book.url!);

      final response = await parseObject.save();

      if (!response.success) {
        return Future.error(ParseErrors.getDescription(response.error!.code));
      }
    } catch (e) {
      return Future.error("Falha ao salvar livro ${e.toString()}");
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

  Future<void> delete(Book book) async {
    final parseObject = ParseObject(keyBookTable)..set(keyBookId, book.id);

    parseObject.set(keyBookStatus, BookStatus.DELETED.index);

    final response = await parseObject.save();
    if (!response.success) {
      return Future.error(ParseErrors.getDescription(response.error!.code));
    }
  }
}
