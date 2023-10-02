import 'package:flutter/material.dart';

class TitleTextFormCreateBook extends StatelessWidget {
  const TitleTextFormCreateBook({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 43,
        fontWeight: FontWeight.w600,
        color: Color.fromRGBO(37, 66, 43, 1),
      ),
    );
  }
}
