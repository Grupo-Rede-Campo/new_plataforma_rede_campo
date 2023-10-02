import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plataforma_rede_campo/models/book_chapter.dart';
import 'package:url_launcher/url_launcher.dart';

class BookChapterTile extends StatelessWidget {
  BookChapterTile({Key? key, required this.bookChapter}) : super(key: key);

  final BookChapter bookChapter;

  TextStyle style = const TextStyle(
    fontSize: 21,
    fontWeight: FontWeight.w600,
    color: Color.fromRGBO(37, 66, 43, 1),
  );

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Container(
        margin: const EdgeInsets.only(bottom: 50),
        padding: const EdgeInsets.all(14),
        height: 420,
        width: 1228,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(19),
          border: Border.all(
            color: const Color.fromRGBO(37, 66, 43, 0.71),
            width: 5,
          ),
        ),
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 0.7,
              child: bookChapter.image != null
                  ? Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: bookChapter.image.url,
                        fit: BoxFit.cover,
                      ),
                    )
                  : SvgPicture.asset('assets/images/sem_imagem.svg'),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 34),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Capitulo: ${bookChapter.title!}',
                      style: style,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Autores:',
                          style: style,
                        ),
                        Text(
                          bookChapter.authors!,
                          style: style,
                        ),
                      ],
                    ),
                    Text(
                      'Livro: ${bookChapter.book!}',
                      style: style,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Organizadores:',
                          style: style,
                        ),
                        Text(
                          bookChapter.organizers!,
                          style: style,
                        ),
                      ],
                    ),
                    Text(
                      'Editora: ${bookChapter.publisher!}',
                      style: style,
                    ),
                    Text(
                      'Ano: ${bookChapter.year!}',
                      style: style,
                    ),
                    InkWell(
                      onTap: () {
                        _launchUrl(url: bookChapter.url!.trim());
                      },
                      child: const Text(
                        "Acesse aqui",
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(37, 66, 43, 1),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
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
