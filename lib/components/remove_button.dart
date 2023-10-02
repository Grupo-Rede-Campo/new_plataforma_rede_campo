import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RemoveButton extends StatelessWidget {
  const RemoveButton({Key? key, required this.message, required this.onTap}) : super(key: key);

  final String message;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: message,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(90),
        child: SvgPicture.asset(
          "assets/icons/remove.svg",
        ),
      ),
    );
  }
}
