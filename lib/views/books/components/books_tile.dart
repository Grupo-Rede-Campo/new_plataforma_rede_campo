import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:plataforma_rede_campo/components/alert_confirm_delete.dart';
import 'package:plataforma_rede_campo/models/book.dart';
import 'package:plataforma_rede_campo/stores/books_store.dart';
import 'package:plataforma_rede_campo/utils/app_routes.dart';
import 'package:plataforma_rede_campo/views/create_book/create_book_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../models/menu_choice.dart';
import '../../../stores/user_manager_store.dart';

class BooksTile extends StatelessWidget {
  BooksTile({Key? key, required this.book, required this.booksStore}) : super(key: key);

  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();
  final BooksStore booksStore;
  final Book book;

  final List<MenuChoice> choices = [
    MenuChoice(index: 0, title: 'Editar'),
    MenuChoice(index: 1, title: 'Excluir'),
  ];

  TextStyle style = const TextStyle(
    fontSize: 21,
    fontWeight: FontWeight.w600,
    color: Color.fromRGBO(37, 66, 43, 1),
  );

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Container(
        margin: EdgeInsets.only(bottom: 50),
        padding: EdgeInsets.all(14),
        height: 369,
        width: 1228,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(19),
          border: Border.all(
            color: const Color.fromRGBO(37, 66, 43, 0.71),
            width: 5,
          ),
        ),
        child: Row(
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: AspectRatio(
                aspectRatio: 0.7,
                child: book.image != null
                    ? Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: book.image.url,
                          fit: BoxFit.cover,
                        ),
                      )
                    : SvgPicture.asset('assets/images/sem_imagem.svg'),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 34),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book.title!,
                      style: style,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Autores:',
                          style: style,
                        ),
                        Text(
                          book.authors!,
                          style: style,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Editora:',
                          style: style,
                        ),
                        Text(
                          book.publisher!,
                          style: style,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Ano:',
                          style: style,
                        ),
                        Text(
                          book.year!,
                          style: style,
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        _launchUrl(url: book.url!.trim());
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
            if (userManagerStore.isLoggedAdm)
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    PopupMenuButton<MenuChoice>(
                      position: PopupMenuPosition.under,
                      onSelected: (choice) {
                        switch (choice.index) {
                          case 0:
                            _editBook(context);
                            break;
                          case 1:
                            _deleteBook(context);
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

  Future<void> _editBook(BuildContext context) async {
    final success = /* await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CreateBookScreen(book: book),
      ),
    );*/
        await Navigator.pushNamed(context, AppRoutes.CREATE_BOOK_SCREEN, arguments: book);
    if (success != null && success == true) {
      booksStore.refesh();
    }
  }

  void _deleteBook(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertConfirmDelete(
        onPressed: () {
          booksStore.deleteBook(book);
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
