import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:plataforma_rede_campo/components/newHeader/component/search_whole_site_dialog/components/navigation_bar_article_tile.dart';
import '../../../../models/article.dart';
import '../../../../models/book.dart';
import '../../../../models/book_chapter.dart';
import '../../../../models/project.dart';
import '../../../../stores/navigation_bar_search_store.dart';
import '../../../empty_search_dialog.dart';
import '../../../search_field.dart';
import 'components/navigation_bar_book_chapter_tile.dart';
import 'components/navigation_bar_book_tile.dart';
import 'components/navigation_bar_project_tile.dart';

class SearchWholeSiteDialog extends StatelessWidget {
  SearchWholeSiteDialog({Key? key}) : super(key: key);

  final NavigationBarSearchStore navigationBarSearchStore = NavigationBarSearchStore();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Dialog(
      insetPadding: EdgeInsets.only(top: screenSize.height * 0.11),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: SizedBox(
        width: 1228,
        child: Observer(
          builder: (context) => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SearchField(
                hintText: 'Buscar...',
                onPressed: (String? text) {
                  navigationBarSearchStore.setSearch(text);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Observer(
                builder: (context) {
                  if (navigationBarSearchStore.error != null) {
                    return Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.error_outline,
                            color: Colors.red,
                            size: 100,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Ocorreu um erro! ${navigationBarSearchStore.error!}",
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        ],
                      ),
                    );
                  }
                  if (navigationBarSearchStore.loading) {
                    return const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Color.fromRGBO(248, 120, 2, 0.93),
                        ),
                      ),
                    );
                  }
                  if (navigationBarSearchStore.allItemsList.isEmpty) {
                    return const Expanded(
                      child: Center(
                        child: EmptySearchDialog(
                          message: 'Nenhum item foi encontrado!',
                        ),
                      ),
                    );
                  }
                  return Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: navigationBarSearchStore.allItemsList.length,
                      itemBuilder: (context, index) {
                        final object = navigationBarSearchStore.allItemsList[index];
                        if (object is Article) {
                          return NavigationBarArticleTile(article: object);
                        } else if (object is Book) {
                          return NavigationBarBookTile(book: object);
                        } else if (object is BookChapter) {
                          return NavigationBarBookChapterTile(bookChapter: object);
                        } else if (object is Project) {
                          return NavigationBarProjectTile(project: object);
                        }
                        return Container();
                      },
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
