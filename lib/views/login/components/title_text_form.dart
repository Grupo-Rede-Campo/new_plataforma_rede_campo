import 'package:flutter/material.dart';

class TitleTextForm extends StatelessWidget {
  const TitleTextForm({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, bottom: 10),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: Color.fromRGBO(255, 255, 255, 1),
        ),
      ),
    );
  }
}
