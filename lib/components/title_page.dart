import 'package:flutter/material.dart';
import 'package:plataforma_rede_campo/theme/app_colors.dart';
import 'package:responsive_framework/responsive_value.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

class TitlePage extends StatelessWidget {
  const TitlePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 22,
      ),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColors.customGreenColor,
          fontSize: ResponsiveValue(
            context,
            defaultValue: 40.0,
            valueWhen: [
              const Condition.smallerThan(
                name: DESKTOP,
                value: 32.0,
              ),
              const Condition.smallerThan(
                name: TABLET,
                value: 28.0,
              ),
            ],
          ).value,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
