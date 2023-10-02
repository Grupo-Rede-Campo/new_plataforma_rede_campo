import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plataforma_rede_campo/theme/app_colors.dart';
import 'package:responsive_framework/responsive_row_column.dart';
import 'package:responsive_framework/responsive_value.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:url_launcher/url_launcher.dart';

class BottonPanel extends StatelessWidget {
  const BottonPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveConstraints(
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: AppColors.primaryColor,
        ),
        child: ResponsiveRowColumn(
          layout: ResponsiveWrapper.of(context).isSmallerThan(TABLET) ? ResponsiveRowColumnType.COLUMN : ResponsiveRowColumnType.ROW,
          rowMainAxisAlignment: MainAxisAlignment.center,
          rowCrossAxisAlignment: CrossAxisAlignment.center,
          columnCrossAxisAlignment: CrossAxisAlignment.center,
          columnMainAxisSize: MainAxisSize.min,
          rowPadding: const EdgeInsets.all(10),
          columnPadding: const EdgeInsets.all(10),
          columnSpacing: 10,
          rowSpacing: 0,
          children: [
            ResponsiveRowColumnItem(
              rowFlex: 2,
              rowFit: FlexFit.tight,
              child: SvgPicture.asset(
                'assets/images/rede_campo.svg',
                fit: BoxFit.contain,
                height: 150,
              ),
            ),
            ResponsiveRowColumnItem(
              rowFlex: 4,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: _launchInstagram,
                        child: SvgPicture.asset(
                          'assets/icons/icon_instagram.svg',
                          width: 35,
                        ),
                      ),
                      /* SizedBox(
                        width: 17,
                      ),
                      InkWell(
                        onTap: () {},
                        child: SvgPicture.asset('icons/facebook.svg'),
                      ),
                      SizedBox(
                        width: 17,
                      ),
                      InkWell(
                        onTap: () {},
                        child: SvgPicture.asset('icons/twitter.svg'),
                      ),*/
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          ' Donec nec mi vitae eros pretium iaculis. Pellentesque consectetur sem nisl, a dignissim ipsum cursus vitae. Praesent lacinia, mi in dapibus accumsan.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.primaryTextColor,
                            fontWeight: FontWeight.w600,
                            fontSize: ResponsiveValue(
                              context,
                              defaultValue: 16.0,
                              valueWhen: [
                                Condition.smallerThan(
                                  name: DESKTOP,
                                  value: 15.0,
                                ),
                              ],
                            ).value,
                            fontFamily: 'SF Pro Display',
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Santa Helena | Paraná | Brasil',
                          style: TextStyle(
                            color: AppColors.primaryTextColor,
                            fontWeight: FontWeight.w600,
                            fontSize: ResponsiveValue(
                              context,
                              defaultValue: 16.0,
                              valueWhen: [
                                Condition.smallerThan(
                                  name: DESKTOP,
                                  value: 15.0,
                                ),
                              ],
                            ).value,
                            fontFamily: 'SF Pro Display',
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            ResponsiveRowColumnItem(
              rowFlex: 2,
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _launchInstagram() async {
  final Uri url = Uri.parse('https://www.instagram.com/rede.campo/?igshid=YmMyMTA2M2Y%3D');
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Não foi possível abrir o link do Instagram: $url';
  }
}

/*
Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(118, 138, 79, 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex: 1,
            child: SvgPicture.asset(
              'assets/images/rede_campo.svg',
              fit: BoxFit.contain,
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: _launchInstagram,
                      child: SvgPicture.asset('assets/icons/icon_instagram.svg'),
                    ),
                    /* SizedBox(
                      width: 17,
                    ),
                    InkWell(
                      onTap: () {},
                      child: SvgPicture.asset('icons/facebook.svg'),
                    ),
                    SizedBox(
                      width: 17,
                    ),
                    InkWell(
                      onTap: () {},
                      child: SvgPicture.asset('icons/twitter.svg'),
                    ),*/
                  ],
                ),
                Container(
                  width: 783,
                  margin: const EdgeInsets.only(top: 20, bottom: 17),
                  child: Column(
                    children: const [
                      Text(
                        ' Donec nec mi vitae eros pretium iaculis. Pellentesque consectetur sem nisl, a dignissim ipsum cursus vitae. Praesent lacinia, mi in dapibus accumsan.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromRGBO(242, 242, 209, 1),
                          fontWeight: FontWeight.w600,
                          fontSize: 25,
                          fontFamily: 'SF Pro Display',
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Santa Helena | Paraná | Brasil',
                        style: TextStyle(
                          color: Color.fromRGBO(242, 242, 209, 1),
                          fontWeight: FontWeight.w600,
                          fontSize: 25,
                          fontFamily: 'SF Pro Display',
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(),
          ),
        ],
      ),
    );
* */
