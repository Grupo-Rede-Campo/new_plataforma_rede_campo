import 'package:ansicolor/ansicolor.dart';
import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';
import 'package:plataforma_rede_campo/models/user.dart';
import 'package:plataforma_rede_campo/repositories/user_repository.dart';

/*Comando queprecisa executar no terminal:
flutter packages pub run build_runner watch
flutter pub run build_runner watch --delete-conflicting-outputs
*/

part 'user_manager_store.g.dart';

AnsiPen greenPen = AnsiPen()..green();

class UserManagerStore = _UserManagerStore with _$UserManagerStore;

abstract class _UserManagerStore with Store {
  //construtor
  _UserManagerStore() {
    _getCurrentUser();
  }

  @observable
  User? user;

  @action
  void setUser(User? value) => user = value;

  @computed
  bool get isLoggedIn => user != null;

  @computed
  bool get isLoggedAdm => isLoggedIn && user?.type == UserType.ADMINISTRADOR;

  @observable
  bool loading = false;

  @action
  void setLoading(bool value) => loading = value;

  //funcao para peagar o usuario ja logado
  @action
  Future<void> _getCurrentUser() async {
    setLoading(true);

    final user = await UserRepository().currentUser();
    if (kDebugMode) {
      print(greenPen("Usuario Mantido Logado: $user"));
    }

    setUser(user);

    setLoading(false);
  }
}
