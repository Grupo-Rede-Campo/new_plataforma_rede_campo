import 'package:ansicolor/ansicolor.dart';
import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';
import 'package:plataforma_rede_campo/helpers/extensions.dart';
import 'package:plataforma_rede_campo/models/project.dart';
import 'package:plataforma_rede_campo/repositories/news_repository.dart';

import '../models/news.dart';
import '../repositories/project_repository.dart';

/*Comando queprecisa executar no terminal:
flutter packages pub run build_runner watch
flutter pub run build_runner watch --delete-conflicting-outputs
*/

part 'home_store.g.dart';

AnsiPen greenPen = AnsiPen()..green();

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {
  _HomeStore() {
    _getNewsList();
    _getNumberProjectsItens();
    _getProjectsList();
  }

  @action
  Future<void> _getNewsList() async {
    try {
      setLoading(true);
      newsList.clear();
      final news = await NewsRepository().getAllNews(page: 0);
      newsList.addAll(news);
      setLoading(false);
      if (kDebugMode) {
        print(greenPen(newsList.length));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    setLoading(false);
  }

  ObservableList<News> newsList = ObservableList<News>();

  ObservableList<Project> projectList = ObservableList<Project>();

  @observable
  int index = 0;

  @observable
  int projectPage = 0;

  @action
  void setProjectPage(int value) => projectPage = value;

  @observable
  int numberProjectItens = 0;

  @action
  void setNumberProjectItens(int value) => numberProjectItens = value;

  @computed
  int get totalPages => (numberProjectItens / 10).ceil();

  @action
  Future<void> setNextProjectPage() async {
    projectPage++;
    _getProjectsList();
  }

  @action
  void setNextIndex() {
    if (index < numberProjectItens - 1) {
      if ((index == ((projectPage + 1) * 10) - 1) && projectList.length - 1 == index) {
        print('index == ((projectPage + 1) * 10) - 1');
        if (projectPage < totalPages - 1) {
          setNextProjectPage();
          index++;
        }
      } else {
        index++;
      }
    }
  }

  @action
  void setPreviousIndex() {
    if (index > 0) {
      index--;
    }
  }

  @action
  Future<void> _getProjectsList() async {
    try {
      setLoadingProjects(true);
      await Future.delayed(
        const Duration(milliseconds: 500),
      );
      final projects = await ProjectRepository().getAllProject(page: projectPage, itemsPerPage: 10);
      projectList.addAll(projects);
      setLoadingProjects(false);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    setLoadingProjects(false);
  }

  @action
  Future<void> _getNumberProjectsItens() async {
    int numberItens = await ProjectRepository().getCountAllProjects();
    setNumberProjectItens(numberItens);
  }

  @observable
  String? email = '';

  @action
  void setEmail(String value) => email = value;

  @computed
  bool get emailValid => email != null && email!.isEmailValid();

  String? get emailError {
    if (!showErrors || emailValid) {
      return null;
    } else {
      return 'E-mail invalido';
    }
  }

  @observable
  bool showErrors = false;

  @action
  void setShowErrors(bool value) => showErrors = value;

  @observable
  String? error;

  @action
  void setError(String? value) => error = value;

  @observable
  bool loading = false;

  @action
  void setLoading(bool value) => loading = value;

  @observable
  bool loadingProjects = false;

  @action
  void setLoadingProjects(bool value) => loadingProjects = value;

  @action
  void invalidSendPressed() => showErrors = true;

  @computed
  dynamic get subscribeNewsletterPressed => (emailValid && !loading) ? _subscribeNewsletter : null;

  @action
  Future<void> _subscribeNewsletter() async {
    setLoading(true);
    await Future.delayed(Duration(seconds: 4));
    setLoading(false);
  }
}
