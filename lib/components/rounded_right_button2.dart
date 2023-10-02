import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RoundedRightButton2 extends StatelessWidget {
  const RoundedRightButton2({Key? key, required this.onTap}) : super(key: key);

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
        'icons/button_right2.svg',
        width: 45,
      ),
    );
  }
}
