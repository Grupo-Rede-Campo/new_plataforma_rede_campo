import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:plataforma_rede_campo/components/title_page.dart';
import 'package:plataforma_rede_campo/models/project.dart';
import 'package:plataforma_rede_campo/stores/project_store.dart';
import '../../components/bottom panel/botton panel.dart';
import '../../components/custom_navigation_bar/custom_navigation_bar.dart';
import '../../components/empty_search_dialog.dart';
import '../../components/pagination_buttons_section.dart';
import 'components/project_tile.dart';

class InnovationAndTechnologyProjectsScreen extends StatelessWidget {
  InnovationAndTechnologyProjectsScreen({Key? key}) : super(key: key);

  ProjectStore projectStore = ProjectStore(projectType: ProjectType.INOVACAOETECNOLOGIA);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(242, 242, 209, 1),
      body: ListView(
        children: [
          CustomNavigationBar(),
          Padding(
            padding: const EdgeInsets.only(
              top: 43,
              bottom: 63,
            ),
            child: Column(
              children: [
                const TitlePage(title: 'Projetos de inovação e tecnologia'),
                Observer(
                  builder: (context) {
                    if (projectStore.error != null) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 100),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.error_outline,
                              color: Colors.red,
                              size: 100,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              "Ocorreu um erro! ${projectStore.error!}",
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ],
                        ),
                      );
                    }
                    if (projectStore.loading) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 100),
                          child: CircularProgressIndicator(
                            color: Color.fromRGBO(37, 66, 43, 0.8),
                          ),
                        ),
                      );
                    }
                    if (projectStore.projectsList.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 100),
                        child: EmptySearchDialog(
                          message: 'Nenhum projeto foi encontrado!',
                        ),
                      );
                    }
                    return Column(
                      children: [
                        ListView.builder(
                          itemCount: projectStore.projectsList.length,
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(
                            top: 100,
                          ),
                          itemBuilder: (context, index) => ProjectTile(
                            project: projectStore.projectsList[index],
                            projectStore: projectStore,
                          ),
                        ),
                        PaginationButtonSection(
                          page: projectStore.page,
                          numberItens: projectStore.numberItens,
                          itemsPerPage: 1,
                          visiblePages: 5,
                          setPage: (int page) {
                            projectStore.setPage(page);
                          },
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          const BottonPanel(),
        ],
      ),
    );
  }
}
