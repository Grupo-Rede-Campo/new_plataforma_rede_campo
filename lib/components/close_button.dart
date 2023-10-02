import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CloseButtonProj extends StatelessWidget {
  const CloseButtonProj({Key? key, required this.message, required this.onTap, required this.height, required this.width})
      : super(key: key);

  final String message;
  final VoidCallback onTap;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: message,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(90),
        child: SvgPicture.asset(
          "icons/remove2.svg",
          height: height,
          width: width,
        ),
      ),
    );
  }
}
