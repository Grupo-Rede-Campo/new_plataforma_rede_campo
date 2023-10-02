import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:plataforma_rede_campo/stores/navigation_bar_store.dart';
import 'package:responsive_framework/responsive_value.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import '../../stores/user_manager_store.dart';
import '../../theme/app_colors.dart';
import '../../utils/app_routes.dart';
import 'component/navigation_bar_button.dart';
import 'component/search_camp.dart';
import 'component/search_whole_site_dialog/search_whole_site_dialog.dart';

class CustomNavigationBar extends StatelessWidget {
  CustomNavigationBar({Key? key}) : super(key: key);

  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

  final NavigationBarStore navigationBarStore = NavigationBarStore();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.backgroundColor,
        border: BorderDirectional(
          bottom: BorderSide(
            color: AppColors.customGreenColor,
            width: 3,
          ),
        ),
      ),
      //height: myHeight,
      height: 70,
      alignment: Alignment.center,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: SvgPicture.asset(
              'assets/images/logo_rede_campo_header.svg',
              width: 150,
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /*ResponsiveVisibility(
                  visible: false,
                  visibleWhen: const [Condition.largerThan(name: TABLET)],
                  child: SecondaryRoutesWidget(
                    label: 'Inicio',
                    secondaryRoutes: [],
                    onTapPrimaryRoute: () {
                      Navigator.of(context).pushNamed(home.route);
                    },
                  ),
                ),
                ResponsiveVisibility(
                  visible: false,
                  visibleWhen: const [Condition.largerThan(name: TABLET)],
                  child: SecondaryRoutesWidget(
                    label: 'Projetos',
                    secondaryRoutes: [researchProjects, extensionProjects, innovationAndTechnologyProjects],
                    secondRouteSelected: (selectedRoute) {
                      Navigator.of(context).pushNamed(selectedRoute);
                    },
                  ),
                ),*/
                ResponsiveVisibility(
                  visible: false,
                  visibleWhen: const [Condition.largerThan(name: TABLET)],
                  child: Observer(
                    builder: (context) => MouseRegion(
                      onHover: (value) {
                        navigationBarStore.setHovering(0, true);
                      },
                      onExit: (event) {
                        navigationBarStore.setHovering(0, false);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          NavigationBarButton(
                            label: 'Inicio',
                            secondaryRoutes: [],
                            onTapPrimaryRoute: () {
                              Navigator.of(context).pushNamed(homeScreen.route);
                            },
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Visibility(
                            maintainAnimation: true,
                            maintainState: true,
                            maintainSize: true,
                            visible: navigationBarStore.isHovering[0],
                            child: Container(height: 2, width: 20, color: AppColors.primaryColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ResponsiveVisibility(
                  visible: false,
                  visibleWhen: const [Condition.largerThan(name: TABLET)],
                  child: Observer(
                    builder: (context) => MouseRegion(
                      onHover: (value) {
                        navigationBarStore.setHovering(1, true);
                      },
                      onExit: (event) {
                        navigationBarStore.setHovering(1, false);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          NavigationBarButton(
                            label: 'Quem somos',
                            secondaryRoutes: [],
                            onTapPrimaryRoute: () {
                              Navigator.of(context).pushNamed(whoWeAreScreen.route);
                            },
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Visibility(
                            maintainAnimation: true,
                            maintainState: true,
                            maintainSize: true,
                            visible: navigationBarStore.isHovering[1],
                            child: Container(height: 2, width: 20, color: AppColors.primaryColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ResponsiveVisibility(
                  visible: false,
                  visibleWhen: const [Condition.largerThan(name: TABLET)],
                  child: Observer(
                    builder: (context) => MouseRegion(
                      onHover: (value) {
                        navigationBarStore.setHovering(2, true);
                      },
                      onExit: (event) {
                        navigationBarStore.setHovering(2, false);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          NavigationBarButton(
                            label: 'Equipe',
                            secondaryRoutes: [],
                            onTapPrimaryRoute: () {
                              Navigator.of(context).pushNamed(aboutScreen.route);
                            },
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Visibility(
                            maintainAnimation: true,
                            maintainState: true,
                            maintainSize: true,
                            visible: navigationBarStore.isHovering[2],
                            child: Container(height: 2, width: 20, color: AppColors.primaryColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ResponsiveVisibility(
                  visible: false,
                  visibleWhen: const [Condition.largerThan(name: TABLET)],
                  child: Observer(
                    builder: (context) => MouseRegion(
                      onHover: (value) {
                        navigationBarStore.setHovering(3, true);
                      },
                      onExit: (event) {
                        navigationBarStore.setHovering(3, false);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          NavigationBarButton(
                            label: 'Projetos',
                            secondaryRoutes: [researchProjectsScreen, extensionProjectsScreen, innovationAndTechnologyProjectsScreen],
                            onSecondRouteSelected: (selectedRoute) {
                              Navigator.of(context).pushNamed(selectedRoute);
                            },
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Visibility(
                            maintainAnimation: true,
                            maintainState: true,
                            maintainSize: true,
                            visible: navigationBarStore.isHovering[3],
                            child: Container(height: 2, width: 20, color: AppColors.primaryColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ResponsiveVisibility(
                  visible: false,
                  visibleWhen: const [Condition.largerThan(name: TABLET)],
                  child: Observer(
                    builder: (context) => MouseRegion(
                      onHover: (value) {
                        navigationBarStore.setHovering(4, true);
                      },
                      onExit: (event) {
                        navigationBarStore.setHovering(4, false);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          NavigationBarButton(
                            label: 'Parceiros',
                            secondaryRoutes: [],
                            onTapPrimaryRoute: () {
                              Navigator.of(context).pushNamed(aboutScreen.route);
                            },
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Visibility(
                            maintainAnimation: true,
                            maintainState: true,
                            maintainSize: true,
                            visible: navigationBarStore.isHovering[4],
                            child: Container(height: 2, width: 20, color: AppColors.primaryColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ResponsiveVisibility(
                  visible: false,
                  visibleWhen: const [Condition.largerThan(name: TABLET)],
                  child: Observer(
                    builder: (context) => MouseRegion(
                      onHover: (value) {
                        navigationBarStore.setHovering(5, true);
                      },
                      onExit: (event) {
                        navigationBarStore.setHovering(5, false);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          NavigationBarButton(
                            label: 'Publicações',
                            secondaryRoutes: [booksScreen, bookChapterScreen, articlesScreen],
                            onSecondRouteSelected: (selectedRoute) {
                              Navigator.of(context).pushNamed(selectedRoute);
                            },
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Visibility(
                            maintainAnimation: true,
                            maintainState: true,
                            maintainSize: true,
                            visible: navigationBarStore.isHovering[5],
                            child: Container(
                              height: 2,
                              width: 20,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ResponsiveVisibility(
                  visible: false,
                  visibleWhen: const [Condition.largerThan(name: TABLET)],
                  child: Observer(
                    builder: (context) => MouseRegion(
                      onHover: (value) {
                        navigationBarStore.setHovering(6, true);
                      },
                      onExit: (event) {
                        navigationBarStore.setHovering(6, false);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          NavigationBarButton(
                            label: 'Notícias ',
                            secondaryRoutes: [newsScreen],
                            onSecondRouteSelected: (selectedRoute) {
                              Navigator.of(context).pushNamed(selectedRoute);
                            },
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Visibility(
                            maintainAnimation: true,
                            maintainState: true,
                            maintainSize: true,
                            visible: navigationBarStore.isHovering[6],
                            child: Container(height: 2, width: 20, color: AppColors.primaryColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ResponsiveVisibility(
                  visible: false,
                  visibleWhen: const [Condition.largerThan(name: TABLET)],
                  child: CustomSearchField(
                    onTap: () {
                      showDialog(
                        context: context,
                        barrierColor: const Color.fromRGBO(242, 242, 209, 0.90),
                        builder: (context) => SearchWholeSiteDialog(),
                      );
                    },
                  ),
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(
                    Icons.person,
                    size: 30,
                    color: AppColors.secondaryColor,
                  ),
                  onPressed: () => Navigator.of(context).pushNamed(AppRoutes.LOGIN_SCREEN),
                ),
                ResponsiveVisibility(
                  visible: false,
                  visibleWhen: const [Condition.smallerThan(name: DESKTOP)],
                  child: IconButton(
                    onPressed: () {
                      Scaffold.of(context).openEndDrawer();
                    },
                    icon: const Icon(Icons.menu),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class RouteItem {
  final String label; // Rótulo do item de rota
  final String route; // Rota

  RouteItem({
    required this.label,
    required this.route,
  });
}

RouteItem homeScreen = RouteItem(label: 'Inicio', route: AppRoutes.HOME_SCREEN);
RouteItem researchProjectsScreen = RouteItem(label: 'Pesquisa', route: AppRoutes.RESEARCH_PROJECTS_SCREEN);
RouteItem extensionProjectsScreen = RouteItem(label: 'Extensão', route: AppRoutes.EXTENSION_PROJECTS_SCREEN);
RouteItem innovationAndTechnologyProjectsScreen = RouteItem(label: 'Inovação e Tecnologia', route: AppRoutes.INNOVATION_AND_TECHNOLOGY_PROJECTS_SCREEN);
RouteItem whoWeAreScreen = RouteItem(label: 'Quem somos', route: AppRoutes.WHO_WE_ARE_SCREEN);
RouteItem aboutScreen = RouteItem(label: 'Quem somos', route: AppRoutes.ABOUT_SCREEN);
RouteItem booksScreen = RouteItem(label: 'Livros', route: AppRoutes.BOOKS_SCREEN);
RouteItem bookChapterScreen = RouteItem(label: 'Capítulo de livro', route: AppRoutes.BOOK_CHAPTER_SCREEN);
RouteItem articlesScreen = RouteItem(label: 'Artigos', route: AppRoutes.ARTICLES_SCREEN);
RouteItem newsScreen = RouteItem(label: 'Notícias ', route: AppRoutes.NEWS_SCREEN);
