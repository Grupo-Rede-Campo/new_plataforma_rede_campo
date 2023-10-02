import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:plataforma_rede_campo/components/custom_rounded_left_button.dart';
import 'package:plataforma_rede_campo/components/custom_rounded_right_button.dart';
import 'package:plataforma_rede_campo/stores/about_store.dart';
import '../../components/bottom panel/botton panel.dart';
import '../../components/newHeader/custom_navigation_bar.dart';
import 'components/person_tile_colaborador.dart';
import 'components/person_tile_membro.dart';
import 'components/person_tile_pesquisador.dart';

class AboutScreen extends StatelessWidget {
  AboutScreen({Key? key}) : super(key: key);

  AboutStore aboutStore = AboutStore();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: ListView(
        children: [
          Container(
            child: CustomNavigationBar(),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 43,
              bottom: 63,
            ),
          ),
          SizedBox(
            height: screenSize.height * 0.045,
          ),
          const Text(
            "Quem somos?",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 60,
              fontWeight: FontWeight.w600,
              color: Color.fromRGBO(134, 205, 47, 1),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: screenSize.width * 0.12,
              top: screenSize.height * 0.045,
              right: screenSize.width * 0.12,
              bottom: screenSize.height * 0.12,
            ),
            child: RichText(
              textAlign: TextAlign.justify,
              text: const TextSpan(
                style: TextStyle(
                  color: Color.fromRGBO(26, 46, 29, 1),
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ), //apply style to all
                children: [
                  TextSpan(
                    text: 'Nossa história \n\n',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: 'A Rede de Pesquisas, Inovação e Extensão em Desenvolvimento Rural ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: '(Rede Campo) ',
                    style: TextStyle(color: Colors.blue),
                  ),
                  TextSpan(
                    text: 'foi constituída em 2019, em alusão ao início de ações de pesquisa e extensão realizadas por docente e estudantes da '
                        'UTFPR Santa Helena e parceiros. No decorrer dos anos, o grupo foi fortalecendo suas parcerias e integrando novos membros, '
                        'formalizando seu registro em 2022.\n\n',
                  ),
                  TextSpan(
                    text:
                        'Atualmente  as ações do grupo relação direta com o Programa de Pós-Graduação em Agroecossistemas (PPGSIS) da Universidade Tecnológica Federal do Paraná (UTFPR) e do '
                        'Programa de Pós-Graduação em Desenvolvimento Rural Sustentável (PGDRS) da Universidade Estadual do Oeste do Paraná (UNIOESTE).\n\n',
                  ),
                  TextSpan(
                    text: 'Integram o grupo pesquisadores da UTFPR, UFS, UFF e IDR-Paraná. \n\n',
                  ),
                  TextSpan(
                    text: 'Objetivos \n\n',
                  ),
                  TextSpan(
                    text: 'Esta rede tem como objetivo desenvolver ações de pesquisa a fim de compreender as mudanças socioeconômicas e culturais presentes nos '
                        'sistemas agroalimentares, na agropecuária, nos mercados e nas políticas públicas, com ênfase na sustentabilidade e nas situações de '
                        'vulnerabilidade, realizando ações de extensão e de inovação para a promoção do desenvolvimento rural equitativo.',
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: screenSize.width * 0.04),
            child: const Text(
              "Pesquisadores",
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Color.fromRGBO(134, 205, 47, 1),
                fontSize: 50,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            height: screenSize.height * 0.40,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenSize.width * 0.04,
              ),
              child: Observer(builder: (context) {
                if (aboutStore.loading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Color.fromRGBO(134, 205, 47, 1),
                    ),
                  );
                }
                if (aboutStore.pesquisadoresList.isEmpty) {
                  return const Center(
                    child: Text(
                      "Nenhum pesquisador encontrado",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'SF Pro Display',
                        color: Color.fromRGBO(26, 46, 29, 1),
                      ),
                    ),
                  );
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomRoundedLeftButton(
                      onTap: () {
                        aboutStore.decrementPressedPesquisador();
                      },
                    ),
                    PersonTilePesquisador(
                      aboutStore: aboutStore,
                      index: aboutStore.indexPesquisadores,
                    ),
                    CustomRoundedRightButton(
                      onTap: () {
                        aboutStore.incrementPressedPesquisador();
                      },
                    ),
                  ],
                );
              }),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: screenSize.width * 0.12,
              left: screenSize.width * 0.04,
            ),
            child: const Text(
              "Membros",
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Color.fromRGBO(134, 205, 47, 1),
                fontSize: 50,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            height: screenSize.height * 0.40,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenSize.width * 0.04,
              ),
              child: Observer(builder: (context) {
                if (aboutStore.loading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  );
                }
                if (aboutStore.membrosList.isEmpty) {
                  return const Center(
                    child: Text(
                      "Nenhum membro encontrado",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'SF Pro Display',
                        color: Color.fromRGBO(26, 46, 29, 1),
                      ),
                    ),
                  );
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomRoundedLeftButton(
                      onTap: () {
                        aboutStore.decrementPressedMembro();
                      },
                    ),
                    PersonTileMembro(
                      aboutStore: aboutStore,
                      index: aboutStore.indexMembros,
                    ),
                    if (aboutStore.membrosList.length > 1)
                      PersonTileMembro(
                        aboutStore: aboutStore,
                        index: aboutStore.indexMembros + 1,
                      ),
                    CustomRoundedRightButton(
                      onTap: () {
                        if (aboutStore.indexMembros < aboutStore.membrosList.length - 2) {
                          aboutStore.incrementPressedMembro();
                        }
                      },
                    ),
                  ],
                );
              }),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: screenSize.width * 0.12,
              left: screenSize.width * 0.04,
            ),
            child: const Text(
              "Colaboradores",
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Color.fromRGBO(134, 205, 47, 1),
                fontSize: 50,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            height: screenSize.height * 0.40,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenSize.width * 0.04,
              ),
              child: Observer(builder: (context) {
                if (aboutStore.loading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  );
                }
                if (aboutStore.colaboradoresList.isEmpty) {
                  return const Center(
                    child: Text(
                      "Nenhum colaborador encontrado",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'SF Pro Display',
                        color: Color.fromRGBO(26, 46, 29, 1),
                      ),
                    ),
                  );
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomRoundedLeftButton(
                      onTap: () {
                        aboutStore.decrementPressedColaborador();
                      },
                    ),
                    PersonTileColaborador(
                      aboutStore: aboutStore,
                      index: aboutStore.indexColaboradores,
                    ),
                    if (aboutStore.colaboradoresList.length > 1)
                      PersonTileColaborador(
                        aboutStore: aboutStore,
                        index: aboutStore.indexColaboradores + 1,
                      ),
                    if (aboutStore.colaboradoresList.length > 2)
                      PersonTileColaborador(
                        aboutStore: aboutStore,
                        index: aboutStore.indexColaboradores + 2,
                      ),
                    CustomRoundedRightButton(
                      onTap: () {
                        if (aboutStore.indexColaboradores < aboutStore.colaboradoresList.length - 3) {
                          aboutStore.incrementPressedColaborador();
                        }
                      },
                    ),
                  ],
                );
              }),
            ),
          ),
          const BottonPanel(),
        ],
      ),
    );
  }
}
