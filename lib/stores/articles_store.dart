import 'package:mobx/mobx.dart';
import 'package:plataforma_rede_campo/models/article.dart';
import 'package:plataforma_rede_campo/repositories/article_repository.dart';

/*Comando queprecisa executar no terminal:
flutter packages pub run build_runner watch
flutter pub run build_runner watch --delete-conflicting-outputs
*/

part 'articles_store.g.dart';

class ArticlesStore = _ArticlesStore with _$ArticlesStore;

abstract class _ArticlesStore with Store {
  _ArticlesStore() {
    autorun((_) async {
      setLoading(true);
      try {
        _getNumberItens();
        await _getArticles(search: search, page: page);
        setError(null);
        setLoading(false);
      } catch (e) {
        setLoading(false);
        setError(e.toString());
      }
    });
  }

  @observable
  ObservableList<Article> articlesList = ObservableList<Article>();

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
    articlesList.clear();
    page = 0;
  }

  @action
  Future<void> _getArticles({String? search, required int page}) async {
    final articles = await ArticleRepository().getAllArticles(
      search: search,
      page: page,
    );
    articlesList.clear();
    articlesList.addAll(articles);
  }

  @action
  void refesh() => _getArticles(search: search, page: page);

  @action
  Future<void> _getNumberItens() async {
    int numberItens = await ArticleRepository().getCountAllArticles(search);
    setNumberItens(numberItens);
  }

  @action
  Future<void> deleteArticle({required Article article}) async {
    setLoading(true);
    await ArticleRepository().delete(article: article);
    refesh();
    setLoading(false);
  }
}
