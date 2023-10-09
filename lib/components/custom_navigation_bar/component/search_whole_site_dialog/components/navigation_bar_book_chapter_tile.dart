import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../models/book_chapter.dart';
import '../../../../../utils/utils.dart';

class NavigationBarBookChapterTile extends StatelessWidget {
  const NavigationBarBookChapterTile({Key? key, required this.bookChapter}) : super(key: key);

  final BookChapter bookChapter;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 30,
      ),
      padding: const EdgeInsets.all(14),
      height: 250,
      width: 1228,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(242, 242, 209, 1),
        border: Border.all(
          color: const Color.fromRGBO(37, 66, 43, 0.71),
          width: 5,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(19),
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
          ),
          const SizedBox(
            width: 34,
          ),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Capitulo: ${bookChapter.title!}',
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(37, 66, 43, 1),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Utils.launchUrlMethod(url: bookChapter.url!.trim());
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
        ],
      ),
    );
  }
}
