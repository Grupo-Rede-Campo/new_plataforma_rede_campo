import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AlertDialogEmailSend extends StatelessWidget {
  const AlertDialogEmailSend({Key? key}) : super(key: key);

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
            "Link de recuperação enviado para o e-mail informado.\nVerifique sua caixa de spam",
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
            width: 290,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(43, 41, 117, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              child: Text(
                'Continuar',
                style: TextStyle(
                  color: Color.fromRGBO(239, 239, 239, 1),
                  fontSize: 40,
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
