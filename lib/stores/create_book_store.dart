import 'package:mobx/mobx.dart';
import 'package:plataforma_rede_campo/models/book.dart';
import 'package:plataforma_rede_campo/repositories/book_repository.dart';

/*Comando queprecisa executar no terminal:
flutter packages pub run build_runner watch
flutter pub run build_runner watch --delete-conflicting-outputs
*/

part 'create_book_store.g.dart';

class CreateBookStore = _CreateBookStore with _$CreateBookStore;

abstract class _CreateBookStore with Store {
  //construtor
  _CreateBookStore(this.book) {
    image = book.image;
    title = book.title ?? '';
    publisher = book.publisher ?? '';
    authors = book.authors ?? '';
    yearText = book.year ?? '';
    url = book.url ?? '';
  }

  final Book book;

  @observable
  dynamic image;

  @action
  void setImage(dynamic value) => image = value;

  @computed
  bool get imageValid => image != null;

  @computed
  String? get imageError {
    if (!showErrors || imageValid) {
      return null;
    } else {
      return 'Imagem obrigatória';
    }
  }

  @observable
  String? title = '';

  @action
  void setTitle(String? value) => title = value;

  @computed
  bool get titleValid => title != null && title!.length >= 5;

  @computed
  String? get titleError {
    if (!showErrors || titleValid) {
      return null;
    } else if (title!.isEmpty) {
      return 'Campo obrigatório';
    } else if (title!.length < 5) {
      return "Título muito curto";
    } else {
      return ('Título invalido');
    }
  }

  @observable
  String? publisher = '';

  @action
  void setPublisher(String? value) => publisher = value;

  @computed
  bool get publisherValid => publisher != null && title!.length >= 5;

  @computed
  String? get publisherError {
    if (!showErrors || publisherValid) {
      return null;
    } else if (publisher!.isEmpty) {
      return 'Campo obrigatório';
    } else if (publisher!.length < 5) {
      return "Editora muito curta";
    } else {
      return ('Editora invalida');
    }
  }

  @observable
  String? authors = '';

  @action
  void setAuthors(String? value) => authors = value;

  @computed
  bool get authorsValid => authors != null && authors!.length >= 5;

  @computed
  String? get authorsError {
    if (!showErrors || authorsValid) {
      return null;
    } else if (authors!.isEmpty) {
      return 'Campo obrigatório';
    } else if (authors!.length < 5) {
      return "Autores muito curto";
    } else {
      return ('Autores invalidos');
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
  String? url = '';

  @action
  void setUrl(String? value) => url = value;

  @computed
  bool get urlValid => url != null && url!.length >= 5;

  @computed
  String? get urlError {
    if (!showErrors || urlValid) {
      return null;
    } else if (url!.isEmpty) {
      return 'Campo obrigatório';
    } else if (url!.length < 5) {
      return "Link muito curto";
    } else {
      return ('Link invalido');
    }
  }

  @observable
  bool loading = false;

  @action
  void setLoading(bool value) => loading = value;

  @observable
  String? error;

  @action
  void setError(String value) => error = value;

  @observable
  bool showErrors = false;

  @action
  void invalidSendPressed() => showErrors = true;

  @computed
  bool get isFormValid => imageValid && titleValid && publisherValid && authorsValid && yearValid && urlValid;

  @computed
  dynamic get savePressed => (isFormValid && !loading) ? _saveBook : null;

  @computed
  dynamic get deletePressed => !loading ? _deleteBook : null;

  @observable
  bool saveSucces = false;

  @action
  void setSaveSucces(bool value) => saveSucces = value;

  @observable
  bool deleteSucces = false;

  @action
  void setDeleteSucces(bool value) => deleteSucces = value;

  @action
  Future<void> _saveBook() async {
    setLoading(true);

    try {
      book.image = image;
      book.title = title;
      book.publisher = publisher;
      book.authors = authors;
      book.year = year.toString();
      book.url = url;
      await BookRepository().saveBook(book);
      print("****************************SAVEEEEEEEEEEEEEE");
      setSaveSucces(true);
    } catch (e) {
      setError(e.toString());
    }
    setLoading(false);
  }

  @action
  Future<void> _deleteBook() async {
    setLoading(true);
    await BookRepository().delete(book);
    setDeleteSucces(true);
    setLoading(false);
  }
}
