import 'dart:math';
import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';
import '../custom_navigation_bar.dart';

class SecondaryRoutesWidget extends StatelessWidget {
  const SecondaryRoutesWidget({
    super.key,
    required this.label,
    this.primaryRoute,
    required this.secondaryRoutes,
    this.onTapPrimaryRoute,
    this.secondRouteSelected,
  });

  final String label;
  final String? primaryRoute;
  final List<RouteItem> secondaryRoutes;
  final void Function()? onTapPrimaryRoute;
  final void Function(String)? secondRouteSelected;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double screenDiagonal = sqrt(pow(height, 2) + pow(width, 2));
    double baseFontSize = 20;
    double fontSize = baseFontSize * screenDiagonal / 1920;

    if (secondaryRoutes.isEmpty) {
      return TextButton(
        onPressed: () {
          onTapPrimaryRoute!();
        },
        child: Text(
          label,
          style: const TextStyle(
            fontFamily: 'SF Pro Display',
            fontWeight: FontWeight.w600,
            color: Color.fromRGBO(82, 82, 82, 1),
          ).copyWith(fontSize: fontSize),
        ),
      );
    } else {
      // If there are secondary routes, return a DropdownButton
      return ButtonTheme(
        child: DropdownButtonHideUnderline(
          child: DropdownButton<RouteItem>(
            hint: Text(label),
            style: const TextStyle(
              fontFamily: 'SF Pro Display',
              fontWeight: FontWeight.w600,
              color: Color.fromRGBO(82, 82, 82, 1),
            ).copyWith(fontSize: fontSize),
            isDense: true,
            elevation: 0,
            dropdownColor: AppColors.backgroundColor,
            items: secondaryRoutes.map((RouteItem routeItem) {
              return DropdownMenuItem<RouteItem>(
                value: routeItem..route,
                child: Text(routeItem.label),
              );
            }).toList(),
            onChanged: (RouteItem? selectedRoute) {
              secondRouteSelected!(selectedRoute!.route);
            },
          ),
        ),
      );
    }
  }
}
