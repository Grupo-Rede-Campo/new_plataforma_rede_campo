import 'package:flutter/material.dart';

class TitleTextFormRegister extends StatelessWidget {
  const TitleTextFormRegister({Key? key, required this.title})
      : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text(
          '•',
          style: TextStyle(
            color: Color.fromRGBO(13, 13, 13, 1),
            fontWeight: FontWeight.w400,
            fontSize: 34,
          ),
        ),
        Text(
          ' ${title}',
          style: const TextStyle(
            color: Color.fromRGBO(13, 13, 13, 1),
            fontWeight: FontWeight.w400,
            fontSize: 34,
          ),
        ),
      ],
    );
  }
}
