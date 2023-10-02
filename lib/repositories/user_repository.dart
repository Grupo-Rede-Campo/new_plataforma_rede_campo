import 'package:ansicolor/ansicolor.dart';
import 'package:flutter/foundation.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:plataforma_rede_campo/repositories/parse_errors.dart';
import 'package:plataforma_rede_campo/repositories/table_keys.dart';
import '../models/user.dart';

AnsiPen greenPen = AnsiPen()..green();

class UserRepository {
  //Cadastra um usuário no Parse Server (se cadastrado com sucesso ja retorna um User com os dados do usuario cadastrado no banco)
  Future<User> signUp(User user) async {
    final parseUser = ParseUser(user.email, user.password, user.email);

    parseUser.set<String>(keyUserName, user.name);
    parseUser.set<String>(keyUserPhone, user.phone);
    parseUser.set(keyUserType, user.type.index);

    final response = await parseUser.signUp();
    //final response = await parseUser.save();

    if (response.success) {
      return mapParseToUser(response.result);
    } else {
      return Future.error(ParseErrors.getDescription(response.error!.code));
    }
  }

  Future<void> signUpPesquisador(User user) async {
    //cadastra um usuario via Cloud Code.

    final ParseCloudFunction function = ParseCloudFunction('createNewUser');

    final Map<String, dynamic> params = user.toJson();

    final response = await function.executeObjectFunction<ParseObject>(parameters: params);

    if (!response.success) {
      return Future.error(ParseErrors.getDescription(response.error!.code));
    }
  }

  Future<User> loginWithEmail(String email, String password) async {
    final parseUser = ParseUser(email, password, null);

    final response = await parseUser.login();

    if (response.success) {
      return mapParseToUser(response.result);
    } else {
      if (response.error!.code == 141) {
        return Future.error(response.error!.message);
      }
      return Future.error(ParseErrors.getDescription(response.error!.code));
    }
  }

  Future<User?> currentUser() async {
    //Obtém o usuário atual logado no servidor
    final parseUser = await ParseUser.currentUser();
    if (parseUser != null) {
      //verifica se a sesao do usuario ja nao esta expirada
      final response = await ParseUser.getCurrentUserFromServer(parseUser.sessionToken);
      if (response!.success) {
        //se a sesao for valida, retorna um objeto com os dados do usuario(que estao no servidor)
        return mapParseToUser(response.result);
      } else {
        //se a sesao do usuario nao for mais valida, faz o logout deste usuario removendo da memoria
        await parseUser.logout();
      }
    }
    return null;
  }

  Future<void> logout() async {
    final ParseUser currentUser = await ParseUser.currentUser();
    await currentUser.logout();
  }

  //funcao para converter um ParseUser (retornado do ParseServer) em um objeto da classe User
  User mapParseToUser(ParseUser parseUser) {
    return User(
      id: parseUser.objectId!,
      name: parseUser.get(keyUserName),
      email: parseUser.get(keyUserEmail),
      phone: parseUser.get(keyUserPhone),
      type: UserType.values[parseUser.get(keyUserType)],
      createdAt: parseUser.get(keyUserCreatedAt),
    );
  }

  //Método para enviar um e-mail de redefinição de senha para o endereço de e-mail do usuário
  Future<void> recoverPassword(String email) async {
    final ParseUser user = ParseUser(email.toLowerCase(), '', email);
    final ParseResponse parseResponse = await user.requestPasswordReset();
    if (!parseResponse.success) {
      return Future.error(ParseErrors.getDescription(parseResponse.error!.code));
    }
  }

  Future<void> enableOrDisableUser({required User user, required bool disable}) async {
    //Ativa ou desativa um usuário

    final ParseCloudFunction function = ParseCloudFunction('enableOrDisableUser');

    final Map<String, dynamic> params = {
      "objectId": '${user.id}',
      "isDisabled": disable,
    };

    final response = await function.execute(parameters: params);

    if (!response.success) {
      return Future.error(ParseErrors.getDescription(response.error!.code));
    }
  }

  Future<List<User>> getAllUsers({String? search, required int page}) async {
    try {
      //definindo que a busca sera por usuarios
      final queryUsers = QueryBuilder<ParseUser>(ParseUser.forQuery());

      //especificando o limite de itens retornados na consulta
      queryUsers.setLimit(10);

      //Pula a quantidade int de resultados
      queryUsers.setAmountToSkip(page * 10);

      //se search for passado
      if (search != null && search.trim().isNotEmpty) {
        queryUsers.whereContains(keyUserName, search, caseSensitive: false);
      }

      //ordena pela data de criacao 'do mais novo para o mais velho'
      queryUsers.orderByDescending(keyArticleCreatedAt);

      final response = await queryUsers.query();

      if (response.success && response.results != null) {
        return response.results!.map((e) => User.fromParse(e)).toList();
      } else if (response.success && response.results == null) {
        return [];
      } else {
        return Future.error(ParseErrors.getDescription(response.error!.code));
      }
    } catch (e) {
      return Future.error('Falha de conexão');
    }
  }

  Future<int> getCountAllUsers(String? search) async {
    try {
      //definindo que a busca sera por usuarios
      final queryUsers = QueryBuilder<ParseUser>(ParseUser.forQuery());

      //se search for passado
      if (search != null && search.trim().isNotEmpty) {
        queryUsers.whereContains(keyUserName, search, caseSensitive: false);
      }

      final response = await queryUsers.count();

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
