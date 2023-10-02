import 'package:flutter/material.dart';

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
        style: const TextStyle(
          color: Color.fromRGBO(37, 66, 43, 1),
          fontSize: 60,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
