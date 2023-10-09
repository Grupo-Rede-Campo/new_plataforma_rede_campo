import 'package:flutter/material.dart';
import 'dart:math';
import '../../../theme/app_colors.dart';
import '../custom_navigation_bar.dart';

class NavigationBarButton extends StatelessWidget {
  const NavigationBarButton({
    Key? key,
    required this.label,
    this.primaryRoute,
    required this.secondaryRoutes,
    this.onTapPrimaryRoute,
    this.onSecondRouteSelected,
  }) : super(key: key);

  final String label;
  final String? primaryRoute;
  final List<RouteItem> secondaryRoutes;
  final void Function()? onTapPrimaryRoute;
  final void Function(String)? onSecondRouteSelected;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double screenDiagonal = sqrt(pow(height, 2) + pow(width, 2));
    double baseFontSize = 20;
    double fontSize = baseFontSize * screenDiagonal / 1920;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: secondaryRoutes.isEmpty
          ? InkWell(
              onTap: () {
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
            )
          : PopupMenuButton(
              tooltip: '',
              color: AppColors.backgroundColor,
              position: PopupMenuPosition.under,
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                label,
                style: const TextStyle(
                  fontFamily: 'SF Pro Display',
                  fontWeight: FontWeight.w600,
                  color: Color.fromRGBO(82, 82, 82, 1),
                ).copyWith(fontSize: fontSize),
              ),
              itemBuilder: (context) {
                List<PopupMenuEntry<String>> items = [];
                for (RouteItem routeItem in secondaryRoutes) {
                  items.add(
                    PopupMenuItem<String>(
                      value: routeItem.route,
                      child: Text(routeItem.label),
                    ),
                  );
                  if (routeItem != secondaryRoutes.last) {
                    items.add(
                      const PopupMenuDivider(
                        height: 0,
                      ),
                    );
                  }
                }
                return items;
              },
              onSelected: (String selectedRoute) {
                onSecondRouteSelected!(selectedRoute);
              },
            ),
    );
  }
}
