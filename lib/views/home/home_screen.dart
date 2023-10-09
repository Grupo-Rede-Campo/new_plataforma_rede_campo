import 'package:flutter/material.dart';
import 'package:plataforma_rede_campo/components/bottom%20panel/botton%20panel.dart';
import 'package:plataforma_rede_campo/components/parceiros_panel/parceiros_panel.dart';
import 'package:plataforma_rede_campo/stores/home_store.dart';
import 'package:plataforma_rede_campo/theme/app_colors.dart';
import 'package:plataforma_rede_campo/views/home/components/projects_section.dart';
import '../../components/custom_navigation_bar/custom_navigation_bar.dart';
import 'components/news_section.dart';
import 'components/section_box_title.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  HomeStore homeStore = HomeStore();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(
          double.infinity, 70,
          //size.height * 0.10,
        ),
        child: CustomNavigationBar(),
      ),
      key: _scaffoldKey,
      endDrawer: const Drawer(),
      body: ListView(
        children: [
          //NewNavigationBarra(),
          const SectionBoxTitle(title: 'Ultimas notícias'),
          NewsSection(homeStore: homeStore),
          const SectionBoxTitle(title: 'Nossos Projetos'),
          ProjectsSection(homeStore: homeStore),
          const SectionBoxTitle(title: 'Quem somos?'),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  //horizontal: 307,
                ),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  alignment: Alignment.center,
                  constraints: const BoxConstraints(
                    maxWidth: 1300,
                  ),
                  child: const Text(
                    'Pellentesque tincidunt felis eu orci porttitor fermentum. Donec nec mi vitae eros pretium iaculis. '
                    'Pellentesque consectetur sem nisl, a dignissim ipsum cursus vitae. Praesent lacinia, mi in dapibus accumsan, '
                    'nulla nisl finibus risus, non luctus elit libero ut purus. Integer eget pharetra nisi. Donec vel molestie enim. '
                    'Sed auctor, ligula sed congue tempus, ligula nisi aliquet eros, vitae iaculis arcu quam mattis ex. '
                    'Donec non dictum tortor, nec porttitor est. Nullam vitae rutrum ante, ut porta neque. In hac habitassed.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'SF Pro Display',
                      color: AppColors.customGreenColor,
                    ),
                  ),
                ),
              ),
              /*const Padding(
                padding: EdgeInsets.only(
                  left: 80,
                  top: 59,
                ),
                child: Text(
                  "Equipe",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'SF Pro Display',
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              ResponsiveWrapper(
                maxWidth: 1000,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  //mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 25),
                          //AssetImage('assets/images/bri.png'),
                          child:  Material(
                            shape: const CircleBorder(),
                            clipBehavior: Clip.hardEdge,
                            color: Colors.transparent,
                            child: Image.asset(
                              'assets/images/bri.png',
                              width: 180,
                              height: 180,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Anderson',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'SF Pro Display',
                            color: Color.fromRGBO(255, 255, 255, 1),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 25),
                          child:  Material(
                            shape: const CircleBorder(),
                            clipBehavior: Clip.hardEdge,
                            color: Colors.transparent,
                            child: Image.asset(
                              'assets/images/bri.png',
                              width: 180,
                              height: 180,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          'Anderson',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'SF Pro Display',
                            color: Color.fromRGBO(255, 255, 255, 1),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 25),
                          child:  Material(
                            shape: const CircleBorder(),
                            clipBehavior: Clip.hardEdge,
                            color: Colors.transparent,
                            child: Image.asset(
                              'assets/images/bri.png',
                              width: 180,
                              height: 180,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          'Anderson',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'SF Pro Display',
                            color: Color.fromRGBO(255, 255, 255, 1),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 25),
                          child:  Material(
                            shape: const CircleBorder(),
                            clipBehavior: Clip.hardEdge,
                            color: Colors.transparent,
                            child: Image.asset(
                              'assets/images/bri.png',
                              width: 180,
                              height: 180,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        */ /*CircleAvatar(
                          radius: 120,
                          backgroundImage: AssetImage('assets/images/bri.png'),
                        ),*/ /*
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          'Anderson',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'SF Pro Display',
                            color: Color.fromRGBO(255, 255, 255, 1),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )*/
            ],
          ),
          const ParceirosPanel(),
          const BottonPanel(),
        ],
      ),
    );
  }
}
