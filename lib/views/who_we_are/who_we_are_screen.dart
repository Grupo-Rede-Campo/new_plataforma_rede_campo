import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plataforma_rede_campo/components/bottom%20panel/botton%20panel.dart';
import '../../components/newHeader/custom_navigation_bar.dart';

class WhoWeAreScreen extends StatelessWidget {
  const WhoWeAreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        children: [
          CustomNavigationBar(),
          SizedBox(
            height: screenSize.height * 0.045,
          ),
          const Text(
            "Quem somos?",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 60,
              fontWeight: FontWeight.w600,
              color: Color.fromRGBO(37, 66, 43, 1),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: screenSize.width * 0.12,
              top: screenSize.height * 0.045,
              right: screenSize.width * 0.12,
              bottom: screenSize.height * 0.045,
            ),
            child: Column(
              children: <Widget>[
                Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                        text: '\nNossa história\n',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          color: Color.fromRGBO(37, 66, 43, 1),
                        ),
                      ),
                      const TextSpan(
                        text: '\nA Rede de Pesquisas, Inovação e Extensão em Desenvolvimento Rural',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color.fromARGB(255, 167, 167, 167),
                        ),
                      ),
                      const TextSpan(
                        text:
                            ' Atualmente, as ações do grupo relação direta com o Programa de Pós-Graduação em Agroecossistemas (PPGSIS) da Universidade Tecnológica Federal do Paraná (UTFPR) e do Programa de Pós-Graduação em Desenvolvimento Rural Sustentável (PGDRS) da Universidade Estadual do Oeste do Paraná (UNIOESTE). Integram o grupo pesquisadores da UTFPR, UFS, UFF e IDR-Paraná.\n\n',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 20,
                          color: Color.fromARGB(255, 167, 167, 167),
                        ),
                      ),
                      const TextSpan(
                        text: '\nObjetivos\n',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          color: Color.fromRGBO(37, 66, 43, 1),
                        ),
                      ),
                      const TextSpan(
                        text:
                            '\nEsta rede tem como objetivo desenvolver ações de pesquisa para compreender as mudanças socioeconômicas e culturais presentes nos sistemas agroalimentares, na agropecuária, nos mercados e nas políticas públicas, com ênfase na sustentabilidade e nas situações de vulnerabilidade. Também realiza ações de extensão e inovação para promover o desenvolvimento rural equitativo.\n\n',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          color: Color.fromARGB(255, 167, 167, 167),
                        ),
                      ),
                      const TextSpan(
                        text: '\nLinhas de Pesquisa\n',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          color: Color.fromRGBO(37, 66, 43, 1),
                        ),
                      ),
                      const TextSpan(
                        text: '\n  ⦁  ',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 30,
                          color: Color.fromARGB(255, 167, 167, 167),
                        ),
                      ),
                      const TextSpan(
                        text: 'Inovação e extensão para o desenvolvimento rural\n',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 20,
                          color: Color.fromARGB(255, 167, 167, 167),
                        ),
                      ),
                      const TextSpan(
                        text: '  ⦁  ',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 30,
                          color: Color.fromARGB(255, 167, 167, 167),
                        ),
                      ),
                      const TextSpan(
                        text: 'Mudanças socioeconômicas e culturais nos espaços rurais e urbanos\n',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 20,
                          color: Color.fromARGB(255, 167, 167, 167),
                        ),
                      ),
                      const TextSpan(
                        text: '\nNossa Identidade Visual\n',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          color: Color.fromRGBO(37, 66, 43, 1),
                        ),
                      ),
                      WidgetSpan(
                        child: SvgPicture.asset('assets/images/logo.svg'),
                      ),
                      //daqui
                      const TextSpan(
                        text: '\n     ',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 30,
                          color: Color.fromARGB(255, 167, 167, 167),
                        ),
                      ),
                      const TextSpan(
                        text: '\n     ',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 30,
                          color: Color.fromARGB(255, 167, 167, 167),
                        ),
                      ),
                      const TextSpan(
                        text:
                            ' Nossa logo busca representar elementos essenciais ao grupo, especialmente sua ação em rede. O grupo é composto por integrantes de diferentes instituições de ensino, pesquisa e extensão nacional e internacional. A rede de interações também reflete nos diferentes olhares, abordagens e teorias utilizados para ações de desenvolvimento rural.',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 20,
                          color: Color.fromARGB(255, 167, 167, 167),
                        ),
                      ),
                      const TextSpan(
                        text: '\n     ',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 30,
                          color: Color.fromARGB(255, 167, 167, 167),
                        ),
                      ),
                      const TextSpan(
                        text:
                            ' Nossa rede busca atuar em aspectos de integração e interação entre rural e urbano, sob diferentes perspectivas e níveis de aproximação, analisando as relações socioeconômicas e culturais, as interações mercadológicas, as transformações tecnológicas e as constantes mudanças no meio rural global. A partir da aproximação das problemáticas que permeiam a relação rural-urbano, buscamos desenvolver produtos que fomentem o desenvolvimento em rede.',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 20,
                          color: Color.fromARGB(255, 167, 167, 167),
                        ),
                      ),
                      const TextSpan(
                        text: '\n     ',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 30,
                          color: Color.fromARGB(255, 167, 167, 167),
                        ),
                      ),
                      const TextSpan(
                        text:
                            ' Assim, a presença da natureza e da agricultura (ilustrada pela árvore, sol, pastagens e lavouras), da pecuária (representada pelo bovino), da casa (representando homens, mulheres, jovens e crianças) e a comunicação (sinal de wi-fi) refletem o esforço de sistematizar a complexidade das ações realizadas pela Rede Campo.',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 20,
                          color: Color.fromARGB(255, 167, 167, 167),
                        ),
                      ),
                      const TextSpan(
                        text: '\n     ',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 30,
                          color: Color.fromARGB(255, 167, 167, 167),
                        ),
                      ),
                      const TextSpan(
                        text:
                            ' A escolha do verde se justifica por representar a vida, a perseverança, a natureza e a esperança. O laranja representa a energia, a coragem, a determinação, o inspirar e o desabrochar. Em consonância, representam a prosperidade que é o que a Rede Campo almeja para o meio rural.',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 20,
                          color: Color.fromARGB(255, 167, 167, 167),
                        ),
                      ),
                      const TextSpan(
                        text: '\n     ',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 30,
                          color: Color.fromARGB(255, 167, 167, 167),
                        ),
                      ),
                      const TextSpan(
                        text: ' Por fim, as interações que se estendem dessa ilustração, fazem alusão aos múltiplos diálogos e trocas que realizamos em nosso grupo.',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 20,
                          color: Color.fromARGB(255, 167, 167, 167),
                        ),
                      ),
                      //até aqui
                      const TextSpan(
                        text: '\n\nContato\n',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          color: Color.fromRGBO(37, 66, 43, 1),
                        ),
                      ),
                      const TextSpan(text: '\nE-mail: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Color.fromARGB(255, 167, 167, 167))),
                      const TextSpan(
                          text: 'gruporedecampo@gmail.com\n\n', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20, color: Color.fromARGB(255, 167, 167, 167))),
                      const TextSpan(
                        text: 'Endereço\n',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          color: Color.fromRGBO(37, 66, 43, 1),
                        ),
                      ),
                      const TextSpan(
                          text: '\nRede Campo\nProlongamento da Rua Cerejeira\nBairro São Luiz\nSanta Helena - PR, Brasil\n85892-000',
                          style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20, color: Color.fromARGB(255, 167, 167, 167))),
                    ],
                  ),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
          const BottonPanel()
        ],
      ),
    );
  }
}
