import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_value.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import '../../../theme/app_colors.dart';

class SectionBoxTitle extends StatelessWidget {
  const SectionBoxTitle({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: AppColors.primaryColor,
        border: BorderDirectional(
          bottom: BorderSide(
            color: AppColors.customGreenColor,
            width: 3,
          ),
        ),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: ResponsiveValue(
            context,
            defaultValue: 22.0,
            valueWhen: [
              const Condition.smallerThan(
                name: DESKTOP,
                value: 18.0,
              ),
              /*const Condition.smallerThan(
                name: TABLET,
                value: 16.0,
              ),*/
            ],
          ).value,
          fontWeight: FontWeight.w600,
          color: AppColors.primaryTextColor,
        ),
      ),
    );
  }
}
