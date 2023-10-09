import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:plataforma_rede_campo/components/bottom%20panel/botton%20panel.dart';
import 'package:plataforma_rede_campo/stores/articles_store.dart';
import 'package:plataforma_rede_campo/views/articles/components/article_tile.dart';

import '../../components/custom_navigation_bar/custom_navigation_bar.dart';
import '../../components/pagination_buttons_section.dart';
import '../../components/search_field.dart';
import '../../components/title_page.dart';
import '../../components/empty_search_dialog.dart';

class ArticlesScreen extends StatelessWidget {
  ArticlesScreen({Key? key}) : super(key: key);

  final ArticlesStore articlesStore = ArticlesStore();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
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
                const TitlePage(title: 'Artigos'),
                Observer(
                  builder: (context) => SearchField(
                    hintText: 'Pesquisar artigos...',
                    onPressed: (String? text) {
                      articlesStore.setSearch(text);
                    },
                  ),
                ),
                Observer(
                  builder: (context) {
                    if (articlesStore.error != null) {
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
                              "Ocorreu um erro! ${articlesStore.error!}",
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
                    if (articlesStore.loading) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 100),
                          child: CircularProgressIndicator(
                            color: Color.fromRGBO(37, 66, 43, 0.8),
                          ),
                        ),
                      );
                    }
                    if (articlesStore.articlesList.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 100),
                        child: EmptySearchDialog(
                          message: 'Nenhum artigo foi encontrado!',
                        ),
                      );
                    }
                    return Column(
                      children: [
                        ListView.builder(
                          itemCount: articlesStore.articlesList.length,
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(
                            top: 100,
                          ),
                          itemBuilder: (context, index) => ArticleTile(
                            articlesStore: articlesStore,
                            article: articlesStore.articlesList[index],
                          ),
                        ),
                        PaginationButtonSection(
                          page: articlesStore.page,
                          numberItens: articlesStore.numberItens,
                          itemsPerPage: 10,
                          visiblePages: 5,
                          setPage: (int page) {
                            articlesStore.setPage(page);
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
