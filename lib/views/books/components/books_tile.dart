import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:plataforma_rede_campo/components/alert_confirm_delete.dart';
import 'package:plataforma_rede_campo/models/book.dart';
import 'package:plataforma_rede_campo/stores/books_store.dart';
import 'package:plataforma_rede_campo/utils/app_routes.dart';
import 'package:plataforma_rede_campo/views/create_book/create_book_screen.dart';
import 'package:responsive_framework/responsive_framework.dart';
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
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Color.fromRGBO(37, 66, 43, 1),
  );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ResponsiveWrapper(
      maxWidth: 1300,
      minWidth: 1300,
      breakpoints: const [
        ResponsiveBreakpoint.autoScaleDown(350, name: MOBILE),
        ResponsiveBreakpoint.autoScaleDown(600, name: TABLET),
        ResponsiveBreakpoint.autoScaleDown(901, name: DESKTOP),
      ],
      defaultScale: true,
      child: Container(
        constraints: const BoxConstraints(
          maxHeight: 350,
        ),
        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 40),
        padding: const EdgeInsets.only(left: 14, bottom: 14, top: 14),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(19),
          border: Border.all(
            color: const Color.fromRGBO(37, 66, 43, 0.71),
            width: 5,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              alignment: Alignment.center,
              constraints: const BoxConstraints(
                maxWidth: 250,
                maxHeight: 350,
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
                      style: style.copyWith(
                        fontSize: ResponsiveValue(
                          context,
                          defaultValue: 18.0,
                          valueWhen: [
                            const Condition.smallerThan(
                              name: DESKTOP,
                              value: 16.0,
                            ),
                          ],
                        ).value,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Autores:',
                          style: style.copyWith(
                            fontSize: ResponsiveValue(
                              context,
                              defaultValue: 18.0,
                              valueWhen: [
                                const Condition.smallerThan(
                                  name: DESKTOP,
                                  value: 16.0,
                                ),
                              ],
                            ).value,
                          ),
                        ),
                        Text(
                          book.authors!,
                          style: style.copyWith(
                            fontSize: ResponsiveValue(
                              context,
                              defaultValue: 18.0,
                              valueWhen: [
                                const Condition.smallerThan(
                                  name: DESKTOP,
                                  value: 16.0,
                                ),
                              ],
                            ).value,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Editora:',
                          style: style.copyWith(
                            fontSize: ResponsiveValue(
                              context,
                              defaultValue: 18.0,
                              valueWhen: [
                                const Condition.smallerThan(
                                  name: DESKTOP,
                                  value: 16.0,
                                ),
                              ],
                            ).value,
                          ),
                        ),
                        Text(
                          book.publisher!,
                          style: style.copyWith(
                            fontSize: ResponsiveValue(
                              context,
                              defaultValue: 18.0,
                              valueWhen: [
                                const Condition.smallerThan(
                                  name: DESKTOP,
                                  value: 16.0,
                                ),
                              ],
                            ).value,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Ano:',
                          style: style.copyWith(
                            fontSize: ResponsiveValue(
                              context,
                              defaultValue: 18.0,
                              valueWhen: [
                                const Condition.smallerThan(
                                  name: DESKTOP,
                                  value: 16.0,
                                ),
                              ],
                            ).value,
                          ),
                        ),
                        Text(
                          book.year!,
                          style: style.copyWith(
                            fontSize: ResponsiveValue(
                              context,
                              defaultValue: 18.0,
                              valueWhen: [
                                const Condition.smallerThan(
                                  name: DESKTOP,
                                  value: 16.0,
                                ),
                              ],
                            ).value,
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        _launchUrl(url: book.url!.trim());
                      },
                      child: Text(
                        'Acesse aqui',
                        style: TextStyle(
                          fontSize: ResponsiveValue(
                            context,
                            defaultValue: 18.0,
                            valueWhen: [
                              const Condition.smallerThan(
                                name: DESKTOP,
                                value: 16.0,
                              ),
                            ],
                          ).value,
                          fontWeight: FontWeight.w400,
                          color: const Color.fromRGBO(37, 66, 43, 1),
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
                padding: const EdgeInsets.only(
                  right: 14,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
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
              ),
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
