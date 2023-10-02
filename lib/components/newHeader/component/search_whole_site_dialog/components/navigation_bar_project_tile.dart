import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../models/project.dart';
import 'navigation_bar_project_dialog.dart';

class NavigationBarProjectTile extends StatelessWidget {
  NavigationBarProjectTile({Key? key, required this.project}) : super(key: key);

  final Project project;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showDialog(
        context: context,
        builder: (context) => NavigationBarProjectDialog(
          project: project,
        ),
      ),
      child: Container(
        margin: const EdgeInsets.only(
          bottom: 30,
        ),
        padding: const EdgeInsets.all(14),
        height: 250,
        width: 1228,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(242, 242, 209, 1),
          border: Border.all(
            color: const Color.fromRGBO(37, 66, 43, 0.71),
            width: 5,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(19),
          ),
        ),
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 0.7,
              child: project.type == ProjectType.INOVACAOETECNOLOGIA
                  ? SvgPicture.asset('assets/images/project_innovation.svg')
                  : project.type == ProjectType.EXTENSAO
                      ? SvgPicture.asset('assets/images/projetct_extension.svg')
                      : SvgPicture.asset('assets/images/projetct_search.svg'),
            ),
            const SizedBox(
              width: 34,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Projeto: ${project.title}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                    style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(37, 66, 43, 1),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
