import 'package:flutter/material.dart';
import 'package:plataforma_rede_campo/models/news.dart';
import 'package:plataforma_rede_campo/theme/app_colors.dart';

import '../../../utils/app_routes.dart';

class NewsTile extends StatelessWidget {
  const NewsTile({Key? key, required this.news}) : super(key: key);

  final News news;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, AppRoutes.NEWS_SCREEN, arguments: news),
      child: Container(
        height: 187,
        margin: const EdgeInsets.symmetric(horizontal: 21, vertical: 8),
        padding: const EdgeInsets.fromLTRB(24, 15, 24, 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.cornsilkColor,
        ),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SelectableText(
              news.field!.areaCnpq,
              textAlign: TextAlign.center,
              maxLines: 1,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                fontFamily: 'Chillax',
                color: AppColors.secondaryColor,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            SelectableText(
              "${news.title}",
              maxLines: 1,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            SelectableText(
              "${news.content}",
              maxLines: 4,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.darkPuceColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
