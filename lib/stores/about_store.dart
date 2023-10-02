import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';
import 'package:plataforma_rede_campo/models/people_to_display.dart';
import 'package:plataforma_rede_campo/repositories/about_repository.dart';

import '../models/user.dart';

/*Comando queprecisa executar no terminal:
flutter packages pub run build_runner watch
flutter pub run build_runner watch --delete-conflicting-outputs
*/

part 'about_store.g.dart';

class AboutStore = _AboutStore with _$AboutStore;

abstract class _AboutStore with Store {
  _AboutStore() {
    _getPesquisadoresList();
  }

  ObservableList pesquisadoresList = ObservableList<PeopleToDisplay>();
  ObservableList membrosList = ObservableList<PeopleToDisplay>();
  ObservableList colaboradoresList = ObservableList<PeopleToDisplay>();

  @action
  Future<void> _getPesquisadoresList() async {
    setLoading(true);
    try {
      pesquisadoresList.clear();
      final pesquisadores = await AboutRepository().getAllPesquisadores();
      pesquisadoresList.addAll(pesquisadores);
      membrosList.clear();
      final membros = await AboutRepository().getAllMembros();
      membrosList.addAll(membros);
      colaboradoresList.clear();
      final colaboradores = await AboutRepository().getAllColaboradores();
      colaboradoresList.addAll(colaboradores);
      if (kDebugMode) {
        print(pesquisadoresList);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    setLoading(false);
  }

  @observable
  int indexPesquisadores = 0;

  @action
  void setIndexPesquisador(int value) => indexPesquisadores = value;

  @observable
  int indexMembros = 0;

  @action
  void setIndexMembros(int value) => indexMembros = value;

  @observable
  int indexColaboradores = 0;

  @action
  void setIndexColaboradores(int value) => indexColaboradores = value;

  @computed
  dynamic get incrementPressedPesquisador => indexPesquisadores < pesquisadoresList.length - 1 ? _incrementPesquisadores : null;

  @computed
  dynamic get incrementPressedMembro => indexMembros < membrosList.length - 1 ? _incrementMembros : null;

  @computed
  dynamic get incrementPressedColaborador => indexColaboradores < colaboradoresList.length - 1 ? _incrementColaboradores : null;

  @computed
  dynamic get decrementPressedPesquisador => indexPesquisadores > 0 ? _decrementPesquisadores : null;

  @computed
  dynamic get decrementPressedMembro => indexMembros > 0 ? _decrementMembros : null;

  @computed
  dynamic get decrementPressedColaborador => indexColaboradores > 0 ? _decrementColaboradores : null;

  @action
  void _incrementPesquisadores() {
    indexPesquisadores++;
  }

  @action
  void _incrementMembros() {
    indexMembros++;
  }

  @action
  void _incrementColaboradores() {
    indexColaboradores++;
  }

  @action
  void _decrementPesquisadores() {
    indexPesquisadores--;
  }

  @action
  void _decrementMembros() {
    indexMembros--;
  }

  @action
  void _decrementColaboradores() {
    print(indexColaboradores);
    indexColaboradores--;
  }

  @observable
  bool loading = false;

  @action
  void setLoading(bool value) => loading = value;
}
