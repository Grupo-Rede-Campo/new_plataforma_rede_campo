import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../home/home_screen.dart';

class AlertDialogSignUpSuccess extends StatelessWidget {
  const AlertDialogSignUpSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return AlertDialog(
      backgroundColor: Color.fromRGBO(255, 255, 255, 0.8),
      contentPadding: EdgeInsets.symmetric(
        horizontal: screenSize.width * 0.023,
        vertical: screenSize.height * 0.07,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(46),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Publicado com sucesso!",
            style: TextStyle(
              color: Color.fromRGBO(38, 89, 188, 1),
              fontSize: 30,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: screenSize.height * 0.05,
          ),
          SvgPicture.asset('icons/done.svg'),
          SizedBox(
            height: screenSize.height * 0.04,
          ),
          SizedBox(
            height: 62,
            width: 400,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(76, 140, 45, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  )),
              child: const Text(
                'Cadastrar novo usuário',
                style: TextStyle(
                  color: Color.fromRGBO(239, 239, 239, 1),
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          SizedBox(
            height: screenSize.height * 0.025,
          ),
          SizedBox(
            height: 62,
            width: 300,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                    (route) => false);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(43, 41, 117, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              child: const Text(
                'Home',
                style: TextStyle(
                  color: Color.fromRGBO(239, 239, 239, 1),
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
