import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../../components/alert_confirm_delete.dart';
import '../../../models/menu_choice.dart';
import '../../../models/project.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../stores/project_store.dart';
import '../../../stores/user_manager_store.dart';
import '../../create_project/create_project_screen.dart';

class ProjectTile extends StatelessWidget {
  ProjectTile({Key? key, required this.project, required this.projectStore}) : super(key: key);

  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();
  final ProjectStore projectStore;
  final Project project;

  final List<MenuChoice> choices = [
    MenuChoice(index: 0, title: 'Editar'),
    MenuChoice(index: 1, title: 'Excluir'),
  ];

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Container(
        margin: const EdgeInsets.only(bottom: 50),
        height: MediaQuery.of(context).size.height * 0.80,
        width: MediaQuery.of(context).size.width * 0.80,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(250, 186, 102, 0.15),
          borderRadius: BorderRadius.circular(33),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100, bottom: 100, right: 100, left: 50),
              child: AspectRatio(
                aspectRatio: 1,
                child: project.type == ProjectType.INOVACAOETECNOLOGIA
                    ? SvgPicture.asset('assets/images/project_innovation.svg')
                    : project.type == ProjectType.EXTENSAO
                        ? SvgPicture.asset('assets/images/projetct_extension.svg')
                        : SvgPicture.asset('assets/images/projetct_search.svg'),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 40,
                  bottom: 21,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      project.title!,
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      project.content!,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.010816,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      "Participantes: ${project.participants!}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (userManagerStore.isLoggedAdm)
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    PopupMenuButton<MenuChoice>(
                      position: PopupMenuPosition.under,
                      onSelected: (choice) {
                        switch (choice.index) {
                          case 0:
                            _editProject(context);
                            break;
                          case 1:
                            _deletProject(context);
                            break;
                        }
                      },
                      icon: const Icon(
                        Icons.more_vert,
                        size: 30,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                      ),
                      color: const Color.fromRGBO(107, 128, 68, 1),
                      itemBuilder: (context) => choices
                          .map(
                            (choice) => PopupMenuItem<MenuChoice>(
                              value: choice,
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 49,
                                vertical: 13,
                              ),
                              child: Center(
                                child: Text(
                                  choice.title,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }

  Future<void> _editProject(BuildContext context) async {
    final success = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CreateProjectScreen(project: project),
      ),
    );
    if (success != null && success == true) {
      print(true);
    }
    if (success != null && success['changedType'] == true || success['delete'] == true) {
      projectStore.resetPage();
    }
    if ((success != null && success['save'] == true)) {
      projectStore.refesh();
    }
  }

  void _deletProject(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertConfirmDelete(
        onPressed: () {
          projectStore.deleteProject(project: project);
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
