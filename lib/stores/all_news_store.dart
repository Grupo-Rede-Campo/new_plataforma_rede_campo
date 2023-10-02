import 'package:ansicolor/ansicolor.dart';
import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';
import '../models/news.dart';
import '../repositories/news_repository.dart';

/*Comando queprecisa executar no terminal:
flutter packages pub run build_runner watch
flutter pub run build_runner watch --delete-conflicting-outputs
*/

part 'all_news_store.g.dart';

AnsiPen greenPen = AnsiPen()..green();

class AllNewsStore = _AllNewsStore with _$AllNewsStore;

abstract class _AllNewsStore with Store {
  _AllNewsStore() {
    autorun((_) async {
      setLoading(true);
      _getNumberItens();
      try {
        _getNumberItens();
        await _getNews(search: search, page: page);
        setError(null);
        setLoading(false);
      } catch (e) {
        setLoading(false);
        setError(e.toString());
        if (kDebugMode) {
          print(greenPen(e.toString()));
        }
      }
    });
  }

  @observable
  String? search;

  @action
  void setSearch(String? value) {
    search = value;
    resetPage();
  }

  ObservableList<News> newsList = ObservableList<News>();

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
  void setPage(int value) {
    page = value;
  }

  @observable
  bool lastPage = false;

  @action
  void loadNextPage() {
    page++;
  }

  @action
  void setLastPage(bool value) => lastPage = value;

  @action
  void _addNews(List<News> news) {
    if (news.length < 10) {
      lastPage = true;
    }
    newsList.addAll(news);
  }

  @action
  void resetPage() {
    page = 0;
    newsList.clear();
  }

  @action
  Future<void> _getNews({String? search, required int page}) async {
    final news = await NewsRepository().getAllNews(
      search: search,
      page: page,
    );
    newsList.clear();
    _addNews(news);
  }

  @action
  void refesh() => _getNews(search: search, page: page);

  @action
  Future<void> _getNumberItens() async {
    int numberItens = await NewsRepository().getCountAllNews(search);
    setNumberItens(numberItens);
  }

  @computed
  int get itemCount => lastPage ? newsList.length : newsList.length + 1;

  @computed
  bool get showProgress => loading && newsList.isEmpty;
}
