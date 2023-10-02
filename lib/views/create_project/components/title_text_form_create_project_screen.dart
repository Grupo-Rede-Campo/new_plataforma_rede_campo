import 'package:flutter/material.dart';

class TitleTextFormCreateProjectScreen extends StatelessWidget {
  const TitleTextFormCreateProjectScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.w600,
        color: Color.fromRGBO(52, 61, 67, 1),
      ),
    );
  }
}
