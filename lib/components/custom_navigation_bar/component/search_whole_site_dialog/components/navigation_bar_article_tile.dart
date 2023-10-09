import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plataforma_rede_campo/models/article.dart';

import '../../../../../utils/utils.dart';

class NavigationBarArticleTile extends StatelessWidget {
  const NavigationBarArticleTile({Key? key, required this.article}) : super(key: key);

  final Article article;

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
              child: SvgPicture.asset('assets/images/article.svg'),
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
                  'Artigo: ${article.title!}',
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
                    Utils.launchUrlMethod(url: article.doi!.trim());
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
