import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plataforma_rede_campo/stores/home_store.dart';
import 'package:plataforma_rede_campo/views/home/components/news_tile.dart';
import 'package:responsive_framework/responsive_row_column.dart';
import 'package:responsive_framework/responsive_value.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import '../../../theme/app_colors.dart';
import 'news_letter_field.dart';

class NewsSection extends StatelessWidget {
  const NewsSection({Key? key, required this.homeStore}) : super(key: key);

  final HomeStore homeStore;

  @override
  Widget build(BuildContext context) {
    return ResponsiveConstraints(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 1300,
              ),
              child: ResponsiveRowColumn(
                layout: ResponsiveWrapper.of(context).isSmallerThan(DESKTOP) ? ResponsiveRowColumnType.COLUMN : ResponsiveRowColumnType.ROW,
                rowMainAxisAlignment: MainAxisAlignment.center,
                rowCrossAxisAlignment: CrossAxisAlignment.start,
                columnMainAxisAlignment: MainAxisAlignment.center,
                columnMainAxisSize: MainAxisSize.min,
                rowSpacing: 30,
                columnSpacing: 20,
                children: [
                  ResponsiveRowColumnItem(
                    rowFlex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AspectRatio(
                          aspectRatio: 2,
                          child: Stack(
                            children: [
                              InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                onTap: () {},
                                child: Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 20),
                                  decoration: const BoxDecoration(
                                    color: Colors.transparent,
                                    image: DecorationImage(
                                      fit: BoxFit.contain,
                                      image: AssetImage('assets/images/trees.png'),
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: InkWell(
                                  onTap: () {},
                                  child: Container(
                                    height: 45,
                                    width: 50,
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      color: AppColors.lightSilver,
                                    ),
                                    child: SvgPicture.asset('assets/icons/arrow_left.svg'),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: InkWell(
                                  onTap: () {},
                                  child: Container(
                                    height: 45,
                                    width: 50,
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      color: AppColors.lightSilver,
                                    ),
                                    child: SvgPicture.asset('assets/icons/arrow_rigth.svg'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 16.0,
                            top: 8,
                            bottom: 4,
                          ),
                          child: Text(
                            'Recuperação da mata Atlântica',
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.customlightGreenAccentColor,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: Text(
                            'Analistas estimam que em alguns anos a mata ira estar completamente restaurada.',
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.darkPuceColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ResponsiveRowColumnItem(
                    rowFlex: 2,
                    child: Observer(
                      builder: (context) => Container(
                        height: 600,
                        decoration: const BoxDecoration(
                          color: AppColors.deepChampagneColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(19),
                          ),
                        ),
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: homeStore.newsList.length,
                          itemBuilder: (context, index) => NewsTile(news: homeStore.newsList[index]),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            NewsLetterField(homeStore: homeStore),
          ],
        ),
      ),
    );
  }
}
