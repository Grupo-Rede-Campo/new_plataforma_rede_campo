import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:plataforma_rede_campo/components/bottom%20panel/botton%20panel.dart';
import 'package:plataforma_rede_campo/stores/books_store.dart';
import 'package:plataforma_rede_campo/views/books/components/books_tile.dart';
import 'package:plataforma_rede_campo/components/empty_search_dialog.dart';
import 'package:plataforma_rede_campo/components/title_page.dart';
import '../../components/newHeader/custom_navigation_bar.dart';
import '../../components/pagination_buttons_section.dart';
import '../../components/search_field.dart';

class BooksScreen extends StatelessWidget {
  BooksScreen({Key? key}) : super(key: key);

  final BooksStore booksStore = BooksStore();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(
          double.infinity, 70,
          //size.height * 0.10,
        ),
        child: CustomNavigationBar(),
      ),
      key: _scaffoldKey,
      endDrawer: const Drawer(),
      backgroundColor: const Color.fromRGBO(242, 242, 209, 1),
      body: ListView(
        children: [
          //CustomNavigationBar(),
          Padding(
            padding: const EdgeInsets.only(
              top: 43,
              bottom: 63,
            ),
            child: Column(
              children: [
                const TitlePage(title: 'Livros'),
                SearchField(
                  hintText: 'Pesquisar livros...',
                  onPressed: (String? text) {
                    booksStore.setSearch(text);
                  },
                ),
                Observer(
                  builder: (context) {
                    if (booksStore.error != null) {
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
                              "Ocorreu um erro! ${booksStore.error!}",
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
                    if (booksStore.loading) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 100),
                          child: CircularProgressIndicator(
                            color: Color.fromRGBO(37, 66, 43, 0.8),
                          ),
                        ),
                      );
                    }
                    if (booksStore.booksList.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 100),
                        child: EmptySearchDialog(
                          message: 'Nenhum livro foi encontrado!',
                        ),
                      );
                    }
                    return Column(
                      children: [
                        ListView.builder(
                          padding: const EdgeInsets.only(
                            top: 100,
                          ),
                          itemCount: booksStore.booksList.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) => SizedBox(
                            child: BooksTile(
                              book: booksStore.booksList[index],
                              booksStore: booksStore,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        PaginationButtonSection(
                          page: booksStore.page,
                          numberItens: booksStore.numberItens,
                          itemsPerPage: 10,
                          visiblePages: 5,
                          setPage: (int page) {
                            booksStore.setPage(page);
                          },
                        ),
                      ],
                    );
                  },
                )
              ],
            ),
          ),
          const BottonPanel(),
        ],
      ),
    );
  }
}
