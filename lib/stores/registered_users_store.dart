import 'package:mobx/mobx.dart';
import 'package:plataforma_rede_campo/repositories/user_repository.dart';
import '../models/user.dart';

/*Comando queprecisa executar no terminal:
flutter packages pub run build_runner watch
flutter pub run build_runner watch --delete-conflicting-outputs
*/

part 'registered_users_store.g.dart';

class RegisteredUsersStore = _RegisteredUsersStore with _$RegisteredUsersStore;

abstract class _RegisteredUsersStore with Store {
  _RegisteredUsersStore() {
    autorun((_) async {
      setLoading(true);
      try {
        _getNumberItens();
        await _getUsers(search: search, page: page);
        setError(null);
        setLoading(false);
      } catch (e) {
        setLoading(false);
        setError(e.toString());
      }
    });
  }

  ObservableList<User> userList = ObservableList<User>();

  @observable
  String? search;

  @action
  void setSearch(String? value) {
    search = value;
    resetPage();
  }

  @observable
  bool loading = false;

  @action
  void setLoading(bool value) => loading = value;

  @observable
  String? error;

  @action
  void setError(String? value) => error = value;

  @observable
  int numberItens = 0;

  @action
  void setNumberItens(int value) => numberItens = value;

  @observable
  int page = 0;

  @action
  void setPage(int value) => page = value;

  @action
  void resetPage() {
    userList.clear();
    page = 0;
  }

  @action
  Future<void> _getUsers({String? search, required int page}) async {
    final users = await UserRepository().getAllUsers(
      search: search,
      page: page,
    );
    userList.clear();
    userList.addAll(users);
  }

  @action
  void refesh() => _getUsers(search: search, page: page);

  @action
  Future<void> _getNumberItens() async {
    int numberItens = await UserRepository().getCountAllUsers(search);
    setNumberItens(numberItens);
  }
}
