import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';

import '../models/user.dart';
import '../repositories/user_repository.dart';

/*Comando queprecisa executar no terminal:
flutter packages pub run build_runner watch
flutter pub run build_runner watch --delete-conflicting-outputs
*/

part 'registered_users_tile_store.g.dart';

class RegisteredUsersTileStore = _RegisteredUsersTileStore with _$RegisteredUsersTileStore;

abstract class _RegisteredUsersTileStore with Store {
  _RegisteredUsersTileStore(this.user);

  @observable
  late User user;

  @observable
  bool loading = false;

  @action
  void setLoading(bool value) => loading = value;

  @observable
  String? error;

  @action
  void setError(String? value) => error = value;

  @action
  Future<void> toggleIsDisabled() async {
    setLoading(true);
    try {
      await UserRepository().enableOrDisableUser(user: user, disable: !user.isDisabled);
      user.isDisabled = !user.isDisabled;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      setError(e.toString());
    }
    setLoading(false);
  }
}
