import 'package:mobx/mobx.dart';

/*Comando queprecisa executar no terminal:
flutter packages pub run build_runner watch
flutter pub run build_runner watch --delete-conflicting-outputs
*/

part 'navigation_bar_store.g.dart';

class NavigationBarStore = _NavigationBarStore with _$NavigationBarStore;

abstract class _NavigationBarStore with Store {
  @observable
  ObservableList<bool> isHovering = ObservableList<bool>.of([false, false, false, false, false, false, false]);

  @action
  void setHovering(int index, bool value) {
    isHovering[index] = value;
  }
}