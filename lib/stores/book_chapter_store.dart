import 'package:mobx/mobx.dart';
import 'package:plataforma_rede_campo/models/book_chapter.dart';

import '../repositories/book_chapter_repository.dart';

/*Comando queprecisa executar no terminal:
flutter packages pub run build_runner watch
flutter pub run build_runner watch --delete-conflicting-outputs
*/

part 'book_chapter_store.g.dart';

class BookChapterStore = _BookChapterStore with _$BookChapterStore;

abstract class _BookChapterStore with Store {
  _BookChapterStore() {
    autorun((_) async {
      setLoading(true);
      try {
        _getNumberItens();
        await _getBookChapters(search: search, page: page);
        setError(null);
        setLoading(false);
      } catch (e) {
        setLoading(false);
        setError(e.toString());
      }
    });
  }

  ObservableList<BookChapter> bookChapterList = ObservableList<BookChapter>();

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
    bookChapterList.clear();
    page = 0;
  }

  @action
  Future<void> _getBookChapters({String? search, required int page}) async {
    final bookChapters = await BookChapterRepository().getAllBookChapters(
      search: search,
      page: page,
    );

    bookChapterList.clear();
    bookChapterList.addAll(bookChapters);
  }

  @action
  void refresh() => _getBookChapters(search: search, page: page);

  @action
  Future<void> _getNumberItens() async {
    int numberItens = await BookChapterRepository().getCountAllBookChapters(search: search);
    setNumberItens(numberItens);
  }
}
