import 'package:mobx/mobx.dart';
import 'package:plataforma_rede_campo/models/article.dart';
import 'package:plataforma_rede_campo/repositories/article_repository.dart';

/*Comando queprecisa executar no terminal:
flutter packages pub run build_runner watch
flutter pub run build_runner watch --delete-conflicting-outputs
*/

part 'create_article_store.g.dart';

class CreateArticleStore = _CreateArticleStore with _$CreateArticleStore;

abstract class _CreateArticleStore with Store {
  _CreateArticleStore(this.article) {
    title = article.title ?? '';
    sumary = article.summary ?? '';
    authors = article.authors ?? '';
    publisher = article.publisher ?? '';
    yearText = article.publicationYear ?? '';
    doi = article.doi ?? '';
  }

  final Article article;

  @observable
  String? title = '';

  @action
  void setTitle(String? value) => title = value;

  @computed
  bool get titleValid => title!.length >= 6;
  String? get titleError {
    if (!showErrors || titleValid) {
      return null;
    } else if (title!.isEmpty) {
      return 'Campo obrigatório';
    } else {
      return 'Título muito curto';
    }
  }

  @observable
  String? sumary = '';

  @action
  void setSumary(String? value) => sumary = value;

  @computed
  bool get sumaryValid => sumary!.length >= 100;
  String? get sumaryError {
    if (!showErrors || sumaryValid) {
      return null;
    } else if (sumary!.isEmpty) {
      return 'Campo obrigatório';
    } else {
      return 'Resumo muito curto';
    }
  }

  @observable
  String? authors = '';

  @action
  void setAuthors(String? value) => authors = value;

  @computed
  bool get authorsValid => authors!.length >= 5;
  String? get authorsError {
    if (!showErrors || authorsValid) {
      return null;
    } else if (authors!.isEmpty) {
      return 'Campo obrigatório';
    } else {
      return 'Autores muito curto';
    }
  }

  @observable
  String? publisher = '';

  @action
  void setPublisher(String? value) => publisher = value;

  @computed
  bool get publisherValid => publisher != null && publisher!.length >= 5;

  @computed
  String? get publisherError {
    if (!showErrors || publisherValid) {
      return null;
    } else if (publisher!.isEmpty) {
      return 'Campo obrigatório';
    } else if (publisher!.length < 5) {
      return "Revista muito curta";
    } else {
      return ('Revista invalida');
    }
  }

  @observable
  String? yearText = '';

  @action
  void setYearText(String? value) => yearText = value;

  @computed
  num get year {
    return num.tryParse(yearText!) ?? 0;
  }

  @computed
  bool get yearValid => year > 1900 && year <= DateTime.now().year;

  @computed
  String? get yearError {
    if (!showErrors || yearValid) {
      return null;
    } else {
      return 'Ano invalido';
    }
  }

  @observable
  String? doi = '';

  @action
  void setDoi(String? value) => doi = value;

  @computed
  bool get doiValid => doi != null && doi!.length >= 5;

  @computed
  String? get doiError {
    if (!showErrors || doiValid) {
      return null;
    } else if (doi!.isEmpty) {
      return 'Campo obrigatório';
    } else if (doi!.length < 5) {
      return "DOI muito curto";
    } else {
      return ('DOI invalido');
    }
  }

  @observable
  bool loading = false;

  @action
  void setLoading(bool value) => loading = value;

  @observable
  bool showErrors = false;

  @action
  void invalidSendPressed() => showErrors = true;

  @observable
  String? error;

  @action
  void setError(String? value) => error = value;

  @observable
  bool saveSucces = false;

  @action
  void setSaveSucces(bool value) => saveSucces = value;

  @observable
  bool deleteSucces = false;

  @action
  void setDeleteSucces(bool value) => deleteSucces = value;

  @computed
  bool get formValid => titleValid && sumaryValid && authorsValid && authorsValid && publisherValid && yearValid && doiValid;

  @computed
  dynamic get publicarPressed => (formValid && !loading) ? _publicar : null;

  @computed
  dynamic get deletePressed => !loading ? _deleteArticle : null;

  @action
  Future<void> _publicar() async {
    setLoading(true);
    setError(null);

    try {
      article.title = title;
      article.summary = sumary;
      article.authors = authors;
      article.publisher = publisher;
      article.publicationYear = year.toString();
      article.doi = doi;
      article.status = ArticleStatus.ACTIVE;
      await ArticleRepository().saveArticle(article);
      setSaveSucces(true);
    } catch (e) {
      setError(e.toString());
    }

    setLoading(false);
  }

  @action
  Future<void> _deleteArticle() async {
    setLoading(true);
    await ArticleRepository().delete(article: article);
    setDeleteSucces(true);
    setLoading(false);
  }
}
