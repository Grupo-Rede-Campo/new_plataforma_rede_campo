import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TopButton extends StatelessWidget {
  const TopButton({Key? key, required this.text, required this.onTap})
      : super(key: key);

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      hoverColor: const Color.fromRGBO(217, 217, 217, 20),
      child: SizedBox(
        height: 350,
        width: 500,
        child: Card(
          color: const Color.fromRGBO(217, 217, 217, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Adicionar",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(57, 51, 51, 1),
                  //fontFamily: "SF Pro Text",
                ),
              ),
              SvgPicture.asset(
                'assets/icons/add.svg',
              ),
              Text(
                text,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(57, 51, 51, 1),
                  //fontFamily: "SF Pro Text",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
