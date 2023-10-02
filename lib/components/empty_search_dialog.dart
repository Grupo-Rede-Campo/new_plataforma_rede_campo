import 'package:flutter/material.dart';

class EmptySearchDialog extends StatelessWidget {
  const EmptySearchDialog({Key? key, required this.message}) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Text(
      message,
      style: const TextStyle(
        color: Color.fromRGBO(25, 46, 29, 1),
        fontSize: 42,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
