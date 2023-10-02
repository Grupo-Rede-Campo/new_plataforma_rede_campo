import 'package:mobx/mobx.dart';

import '../repositories/navigation_bar_search_repository.dart';

/*Comando queprecisa executar no terminal:
flutter packages pub run build_runner watch
flutter pub run build_runner watch --delete-conflicting-outputs
*/

part 'navigation_bar_search_store.g.dart';

class NavigationBarSearchStore = _NavigationBarSearchStore with _$NavigationBarSearchStore;

abstract class _NavigationBarSearchStore with Store {
  _NavigationBarSearchStore() {
    autorun((_) async {
      setLoading(true);
      try {
        /*_getNumberItens();*/
        await _getAllItems(search: search /*, page: 0*/);
        setError(null);
        setLoading(false);
      } catch (e) {
        setLoading(false);
        setError(e.toString());
      }
    });
  }

  ObservableList<Object> allItemsList = ObservableList();

  @observable
  String? search;

  @action
  void setSearch(String? value) {
    search = value;
    //resetPage();
  }

  @observable
  bool loading = false;

  @action
  void setLoading(bool value) => loading = value;

  @observable
  String? error;

  @action
  void setError(String? value) => error = value;

  @action
  Future<void> _getAllItems({String? search /*, required int page*/}) async {
    final items = await NavigationBarSearchRepository().searchAllItems(
      search: search,
      //page: page,
    );
    allItemsList.clear();
    allItemsList.addAll(items);
  }
}
