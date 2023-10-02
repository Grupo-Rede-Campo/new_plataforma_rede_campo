import 'package:mobx/mobx.dart';
import 'package:plataforma_rede_campo/repositories/book_repository.dart';
import '../models/book.dart';

/*Comando queprecisa executar no terminal:
flutter packages pub run build_runner watch
flutter pub run build_runner watch --delete-conflicting-outputs
*/

part 'books_store.g.dart';

class BooksStore = _BooksStore with _$BooksStore;

abstract class _BooksStore with Store {
  _BooksStore() {
    autorun((_) async {
      setLoading(true);
      try {
        _getNumberItens();
        await _getBooks(search: search, page: page);
        setError(null);
        setLoading(false);
      } catch (e) {
        setLoading(false);
        setError(e.toString());
      }
    });
  }

  @observable
  ObservableList<Book> booksList = ObservableList<Book>();

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
    booksList.clear();
    page = 0;
  }

  @action
  Future<void> _getBooks({String? search, required int page}) async {
    final books = await BookRepository().getAllBooks(
      search: search,
      page: page,
    );
    booksList.clear();
    booksList.addAll(books);
  }

  @action
  void refesh() => _getBooks(search: search, page: page);

  @action
  Future<void> _getNumberItens() async {
    int numberItens = await BookRepository().getCountAllBooks(search);
    setNumberItens(numberItens);
  }

  @action
  Future<void> deleteBook(Book book) async {
    setLoading(true);
    await BookRepository().delete(book);
    refesh();
    setLoading(false);
  }
}
