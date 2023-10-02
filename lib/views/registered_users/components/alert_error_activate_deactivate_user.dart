import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AlertErrorActiveDeactiveUser extends StatelessWidget {
  const AlertErrorActiveDeactiveUser({Key? key, required this.message, required this.onPressed}) : super(key: key);

  final String message;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 50,
          vertical: 60,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(46),
          color: Colors.redAccent,
        ),
        child: Column(
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/icon_warning.svg',
                  height: 80,
                ),
                const SizedBox(
                  width: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'ERRO',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      message,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              width: 290,
              height: 50,
              child: ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  foregroundColor: const Color.fromRGBO(60, 78, 37, 1),
                  backgroundColor: Colors.white,
                  textStyle: const TextStyle(
                    fontSize: 25,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Continuar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
