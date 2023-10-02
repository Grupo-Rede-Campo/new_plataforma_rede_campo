import 'package:mobx/mobx.dart';
import 'package:plataforma_rede_campo/repositories/news_repository.dart';
import '../models/news.dart';

/*Comando queprecisa executar no terminal:
flutter packages pub run build_runner watch
flutter pub run build_runner watch --delete-conflicting-outputs
*/

part 'nova_noticia_store.g.dart';

class NovaNoticiaStore = _NovaNoticiaStore with _$NovaNoticiaStore;

abstract class _NovaNoticiaStore with Store {
  //construtor
  _NovaNoticiaStore(this.news) {
    print(news);

    image1 = news.image1;
    image2 = news.image2;
    title = news.title ?? '';
    titleImage2 = news.titleImage2 ?? '';
    content = news.content ?? '';
    optionalContent = news.optionalContent ?? '';
  }

  final News news;

  @observable
  dynamic image1;

  @action
  void setImage1(dynamic value) => image1 = value;

  @observable
  dynamic image2;

  @action
  void setImage2(dynamic value) => image2 = value;

  @computed
  bool get image1Valid => image1 != null;

  String? get image1Error {
    if (!showErrors || image1Valid) {
      return null;
    } else {
      return 'Insira imagen';
    }
  }

  @computed
  bool get image2Valid => image2 != null;

  String? get image2Error {
    if (!showErrors || formularioOpcionalValid || image2Valid) {
      return null;
    } else {
      return 'Insira imagen';
    }
  }

  @observable
  String? titleImage2 = '';

  @action
  void setTitleImage2(String? value) => titleImage2 = value;

  @computed
  bool get titleImage2Valid => titleImage2!.length >= 6;
  String? get titleImage2Error {
    if (!showErrors || formularioOpcionalValid || titleImage2Valid) {
      return null;
    } else if (titleImage2!.isEmpty) {
      return 'Campo obrigatório';
    } else {
      return 'Título muito curto';
    }
  }

  @observable
  String? optionalContent = '';

  @action
  void setOptionalContent(String? value) => optionalContent = value;

  @computed
  bool get optionalContentValid => optionalContent == null || optionalContent!.isEmpty || optionalContent!.length >= 6;
  String? get optionalContentError {
    if (!showErrors || optionalContentValid) {
      return null;
    } else if (optionalContent!.isEmpty) {
      return 'Campo obrigatório';
    } else {
      return 'Conteúdo muito curto';
    }
  }

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
  String? content = '';

  @action
  void setContent(String? value) => content = value;

  @computed
  bool get contentValid => content!.length >= 6;
  String? get ContentError {
    if (!showErrors || contentValid) {
      return null;
    } else if (content!.isEmpty) {
      return 'Campo obrigatório';
    } else {
      return 'Conteúdo muito curto';
    }
  }

  @computed
  bool get formularioOpcionalValid => (image2 == null && titleImage2!.isEmpty) || (image2Valid && titleImage2Valid);

  @computed
  //bool get formValid => image1Valid && titleValid && ContentValid && optionalContentValid && formularioOpcionalValid;
  bool get formValid => image1Valid && titleValid && contentValid && formularioOpcionalValid;

  @computed
  dynamic get publicarPressed => (formValid && !loading) ? _save : null;

  @observable
  bool loading = false;

  @action
  void setLoading(bool value) => loading = value;

  @observable
  bool showErrors = false;

  @observable
  bool saveSuccess = false;

  @action
  void setSaveSuccess(bool value) => saveSuccess = value;

  @action
  void invalidSendPressed() => showErrors = true;

  @observable
  String? error;

  @action
  void setError(String? value) => error = value;

  @action
  Future<void> _save() async {
    setLoading(true);
    setError(null);

    news.title = title;
    news.image1 = image1;
    news.image2 = image2;
    news.content = content;
    news.titleImage2 = titleImage2;
    news.optionalContent = optionalContent;

    try {
      await NewsRepository().saveNews(news);
      saveSuccess = true;
    } catch (e) {
      setError(e.toString());
    }

    setLoading(false);
  }
}
