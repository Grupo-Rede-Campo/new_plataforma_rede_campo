import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plataforma_rede_campo/components/bottom%20panel/botton%20panel.dart';
import 'package:plataforma_rede_campo/components/sign_out_button.dart';
import 'package:plataforma_rede_campo/views/home_screen_pesquisador/components/bottom_button.dart';
import '../../components/custom_navigation_bar/custom_navigation_bar.dart';
import '../create_news/create_news_screen.dart';
import '../create_project/create_project_screen.dart';
import '../register/register_screen.dart';
import 'components/top_button.dart';

class HomeScreenPesquisador extends StatelessWidget {
  const HomeScreenPesquisador({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: ListView(
        children: [
          CustomNavigationBar(),
          Stack(
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 145,
                  ),
                  const Text(
                    "Bem-vindo pesquisador.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 56, fontWeight: FontWeight.w600, fontFamily: "Chillax"),
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  const Text(
                    "O que deseja fazer?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.w500,
                      //fontFamily: "SF Pro Text",
                    ),
                  ),
                  const SizedBox(
                    height: 85,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TopButton(
                        text: 'novo projeto',
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => CreateProjectScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        width: 60,
                      ),
                      TopButton(
                        text: 'nova notícia',
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => CreateNewsScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 67,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BottonButton(
                        text: 'Editar projetos',
                        onTap: () {},
                      ),
                      const SizedBox(
                        width: 60,
                      ),
                      BottonButton(
                        text: 'Editar noticias',
                        onTap: () {},
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 67,
                  ),
                ],
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 100,
                    right: 72,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Tooltip(
                        message: "Editar Conta",
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => RegisterScreen(),
                              ),
                            );
                          },
                          child: SvgPicture.asset(
                            'assets/icons/account_settings.svg',
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 32,
                      ),
                      SignOutButton(),
                    ],
                  ),
                ),
              ),
            ],
          ),
          BottonPanel(),
        ],
      ),
    );
  }
}
