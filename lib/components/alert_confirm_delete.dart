import 'package:flutter/material.dart';

class AlertConfirmDelete extends StatelessWidget {
  const AlertConfirmDelete({Key? key, required this.onPressed}) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Confirmar exclusão?"),
      actions: [
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: const Text('Não'),
        ),
        TextButton(
          onPressed: onPressed,
          child: const Text('Sim'),
        ),
      ],
    );
  }
}
