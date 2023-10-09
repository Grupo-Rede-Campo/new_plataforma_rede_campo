import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:plataforma_rede_campo/components/bottom%20panel/botton%20panel.dart';
import 'package:plataforma_rede_campo/components/search_field.dart';
import 'package:plataforma_rede_campo/components/title_page.dart';
import 'package:plataforma_rede_campo/stores/book_chapter_store.dart';
import 'package:plataforma_rede_campo/views/book_chapter/components/book_chapter_tile.dart';
import '../../components/custom_navigation_bar/custom_navigation_bar.dart';
import '../../components/empty_search_dialog.dart';
import '../../components/pagination_buttons_section.dart';

class BookChapterScreen extends StatelessWidget {
  BookChapterScreen({Key? key}) : super(key: key);

  BookChapterStore bookChapterStore = BookChapterStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(242, 242, 209, 1),
      body: ListView(
        children: [
          CustomNavigationBar(),
          Padding(
            padding: const EdgeInsets.only(
              top: 43,
              bottom: 63,
            ),
            child: Column(
              children: [
                const TitlePage(title: 'Capitulos de livros'),
                SearchField(
                  onPressed: () {},
                  hintText: 'Pesquisar capitulos...',
                ),
                Observer(
                  builder: (context) {
                    if (bookChapterStore.error != null) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 100),
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
                              "Ocorreu um erro! ${bookChapterStore.error!}",
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
                    if (bookChapterStore.loading) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 100),
                          child: CircularProgressIndicator(
                            color: Color.fromRGBO(37, 66, 43, 0.8),
                          ),
                        ),
                      );
                    }
                    if (bookChapterStore.bookChapterList.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 100),
                        child: EmptySearchDialog(
                          message: 'Nenhum capitulo foi encontrado!',
                        ),
                      );
                    }
                    return Column(
                      children: [
                        ListView.builder(
                          padding: const EdgeInsets.only(
                            top: 100,
                          ),
                          itemCount: bookChapterStore.bookChapterList.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) => SizedBox(
                            child: BookChapterTile(
                              bookChapter: bookChapterStore.bookChapterList[index],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        PaginationButtonSection(
                          page: bookChapterStore.page,
                          numberItens: bookChapterStore.numberItens,
                          itemsPerPage: 10,
                          visiblePages: 5,
                          setPage: (int page) {
                            bookChapterStore.setPage(page);
                          },
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          const BottonPanel(),
        ],
      ),
    );
  }
}
