import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:plataforma_rede_campo/helpers/extensions.dart';
import 'package:plataforma_rede_campo/stores/all_news_store.dart';
import '../../../models/menu_choice.dart';
import '../../../models/news.dart';
import '../../../stores/user_manager_store.dart';
import '../../../utils/app_routes.dart';
import '../../create_news/create_news_screen.dart';
import '../../news/news_screen.dart';

class NewsTile extends StatelessWidget {
  NewsTile({Key? key, required this.news, required this.allNewsStore}) : super(key: key);

  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();
  final News news;
  final AllNewsStore allNewsStore;

  final List<MenuChoice> choices = [
    MenuChoice(index: 0, title: 'Editar'),
    MenuChoice(index: 1, title: 'Excluir'),
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, AppRoutes.NEWS_SCREEN, arguments: news),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(250, 186, 102, 0.45),
          borderRadius: BorderRadius.all(Radius.circular(33)),
        ),
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 1.2,
              child: CachedNetworkImage(
                imageUrl: news.image1.url,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      news.createdAt!.formattedDate(),
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            news.title!,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        if (userManagerStore.isLoggedAdm)
                          PopupMenuButton<MenuChoice>(
                            onSelected: (choice) {
                              switch (choice.index) {
                                case 0:
                                  editNews(context);
                                  break;
                                case 1:
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
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      news.content!,
                      maxLines: 11, // set the maximum number of lines
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color.fromRGBO(52, 61, 67, 1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> editNews(BuildContext context) async {
    final success = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CreateNewsScreen(news: news),
      ),
    );
    if (success != null && success == true) {
      allNewsStore.refesh();
    }
  }

/*
void deleteNews(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => DialogPlatform(
      title: 'Excluído',
      content: 'Confirmar a exclusão de \'${ad.title}\'?',
      textNoButton: 'Não',
      textYesButton: 'Sim',
      actionNo: () => Navigator.of(context).pop(),
      actionYes: () async {
        store.deleteAd(ad);
        Navigator.of(context).pop();
      },
    ),
  );
}*/

}

/*class MenuChoice {
  MenuChoice({
    required this.index,
    required this.title,
  });

  final int index;
  final String title;
}*/
