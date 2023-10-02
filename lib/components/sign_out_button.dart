import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../views/login/login_screen.dart';

class SignOutButton extends StatelessWidget {
  const SignOutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: "Sair",
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ),
            (route) => false,
          );
        },
        child: SvgPicture.asset('assets/icons/sign_out.svg'),
      ),
    );
  }
}
