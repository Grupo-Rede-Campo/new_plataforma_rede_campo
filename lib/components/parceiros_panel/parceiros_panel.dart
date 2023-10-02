import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plataforma_rede_campo/theme/app_colors.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ParceirosPanel extends StatelessWidget {
  const ParceirosPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 30,
          ),
          const Text(
            "Parceiros",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w600,
              fontFamily: 'SF Pro Display',
              color: AppColors.primaryColor,
            ),
          ),
          ResponsiveRowColumn(
            layout: ResponsiveWrapper.of(context).isSmallerThan(TABLET) ? ResponsiveRowColumnType.COLUMN : ResponsiveRowColumnType.ROW,
            rowMainAxisAlignment: MainAxisAlignment.center,
            rowCrossAxisAlignment: CrossAxisAlignment.center,
            columnCrossAxisAlignment: CrossAxisAlignment.center,
            columnMainAxisSize: MainAxisSize.min,
            rowPadding: const EdgeInsets.all(20),
            columnPadding: const EdgeInsets.all(20),
            columnSpacing: 50,
            rowSpacing: 50,
            children: [
              ResponsiveRowColumnItem(
                rowFlex: 1,
                child: SvgPicture.asset(
                  'assets/images/utfpr.svg',
                  width: 200,
                ),
              ),
              ResponsiveRowColumnItem(
                rowFlex: 1,
                child: Image.asset(
                  'assets/images/idr_pr.png',
                  width: 200,
                ),
              ),
              ResponsiveRowColumnItem(
                rowFlex: 1,
                child: SvgPicture.asset(
                  'assets/images/prefeitura.svg',
                  height: 150,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
