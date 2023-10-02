import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../components/alert_confirm_delete.dart';
import '../../../models/article.dart';
import '../../../models/menu_choice.dart';
import '../../../stores/articles_store.dart';
import '../../create_article/create_article_screen.dart';

class ArticleTile extends StatelessWidget {
  ArticleTile({Key? key, required this.article, required this.articlesStore}) : super(key: key);

  final ArticlesStore articlesStore;
  final Article article;

  final List<MenuChoice> choices = [
    MenuChoice(index: 0, title: 'Editar'),
    MenuChoice(index: 1, title: 'Excluir'),
  ];

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Container(
        margin: const EdgeInsets.only(bottom: 50),
        height: 449,
        width: 1274,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(250, 186, 102, 0.15),
          borderRadius: BorderRadius.circular(33),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(100),
              child: AspectRatio(
                aspectRatio: 1,
                child: SvgPicture.asset('assets/images/article.svg'),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 40,
                  bottom: 21,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      article.title!,
                      style: const TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      article.summary!,
                      maxLines: 5,
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      article.authors!,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      'Revista: ${article.publisher}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      'Ano: ${article.publicationYear}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _launchUrl(url: article.doi!.trim());
                      },
                      child: const Text(
                        'Acesse aqui',
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(37, 66, 43, 1),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  PopupMenuButton<MenuChoice>(
                    position: PopupMenuPosition.under,
                    onSelected: (choice) {
                      switch (choice.index) {
                        case 0:
                          _editArticle(context);
                          break;
                        case 1:
                          _deleteArticle(context);
                          break;
                      }
                    },
                    icon: const Icon(
                      Icons.more_vert,
                      size: 30,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                    color: const Color.fromRGBO(107, 128, 68, 1),
                    itemBuilder: (context) => choices
                        .map(
                          (choice) => PopupMenuItem<MenuChoice>(
                            value: choice,
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 49,
                              vertical: 13,
                            ),
                            child: Center(
                              child: Text(
                                choice.title,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _editArticle(BuildContext context) async {
    final success = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CreateArticleScreen(article: article),
      ),
    );
    if (success != null && success == true) {
      articlesStore.refesh();
    }
  }

  void _deleteArticle(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertConfirmDelete(
        onPressed: () {
          articlesStore.deleteArticle(article: article);
          Navigator.of(context).pop();
        },
      ),
    );
  }
}

Future<void> _launchUrl({required String url}) async {
  final Uri _url = Uri.parse(url);
  if (await canLaunchUrl(_url)) {
    await launchUrl(_url);
  } else {
    throw 'Não foi possível abrir o link: $url';
  }
}
