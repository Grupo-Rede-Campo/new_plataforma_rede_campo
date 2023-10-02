import 'package:flutter/material.dart';

class RadioLIstTileCreateProject extends StatelessWidget {
  const RadioLIstTileCreateProject({Key? key, required this.title, required this.groupValue, required this.value, required this.onChanged})
      : super(key: key);

  final String title;
  final Object value;
  final Object groupValue;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio(
            value: value,
            groupValue: groupValue,
            activeColor: const Color.fromRGBO(8, 64, 20, 1),
            onChanged: (value) {
              onChanged();
            }),
        Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
