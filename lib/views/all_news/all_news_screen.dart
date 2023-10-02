import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:plataforma_rede_campo/components/newHeader/custom_navigation_bar.dart';
import 'package:plataforma_rede_campo/components/title_page.dart';
import 'package:plataforma_rede_campo/stores/all_news_store.dart';
import 'package:plataforma_rede_campo/views/all_news/components/news_tile.dart';
import '../../components/bottom panel/botton panel.dart';
import '../../components/pagination_buttons_section.dart';
import '../../components/search_field.dart';

class AllNewsScreen extends StatelessWidget {
  AllNewsScreen({Key? key}) : super(key: key);

  final AllNewsStore allNewsStore = AllNewsStore();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(242, 242, 209, 1),
      body: ListView(
        children: [
          CustomNavigationBar(),
          Padding(
            padding: const EdgeInsets.only(
              top: 43,
              left: 160,
              right: 160,
              bottom: 63,
            ),
            child: Column(
              children: [
                const TitlePage(title: 'Notícias'),
                SearchField(
                  hintText: 'Pesquisar notícias...',
                  onPressed: (String? text) {
                    allNewsStore.setSearch(text);
                  },
                ),
                Observer(
                  builder: (context) {
                    if (allNewsStore.error != null) {
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
                              "Ocorreu um erro! ${allNewsStore.error!}",
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
                    if (allNewsStore.loading) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 100),
                          child: CircularProgressIndicator(
                            color: Color.fromRGBO(37, 66, 43, 0.8),
                          ),
                        ),
                      );
                    }
                    if (allNewsStore.newsList.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 100),
                        child: Text(
                          'Nenhuma notícia foi encontrada!',
                          style: TextStyle(
                            color: Color.fromRGBO(25, 46, 29, 1),
                            fontSize: 42,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }
                    return Column(
                      children: [
                        GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            // gridDelegate definimos como os itens serao exibidos na tela
                            crossAxisCount: 2, //num de items na horizontal
                            mainAxisSpacing: 31,
                            crossAxisSpacing: 30,
                            childAspectRatio: 508 / 175,
                          ),
                          padding: const EdgeInsets.only(
                            top: 100,
                          ),
                          itemCount: allNewsStore.newsList.length,
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return NewsTile(
                              news: allNewsStore.newsList[index],
                              allNewsStore: allNewsStore,
                            );
                          },
                        ),
                        const SizedBox(
                          height: 100,
                        ),
                        PaginationButtonSection(
                          page: allNewsStore.page,
                          numberItens: allNewsStore.numberItens,
                          itemsPerPage: 10,
                          visiblePages: 5,
                          setPage: (int page) {
                            allNewsStore.setPage(page);
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
