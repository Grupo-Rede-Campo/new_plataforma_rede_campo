import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomRoundedRightButton extends StatelessWidget {
  const CustomRoundedRightButton({Key? key, required this.onTap}) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      focusColor: Colors.white54,
      hoverColor: Colors.white54,
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(90),
      ),
      child: SvgPicture.asset(
        'assets/icons/button_right.svg',
        width: 45,
      ),
    );
  }
}
