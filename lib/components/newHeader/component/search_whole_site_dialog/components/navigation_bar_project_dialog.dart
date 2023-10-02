import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plataforma_rede_campo/components/remove_button.dart';
import 'package:plataforma_rede_campo/models/project.dart';

class NavigationBarProjectDialog extends StatelessWidget {
  const NavigationBarProjectDialog({Key? key, required this.project}) : super(key: key);

  final Project project;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(33),
      ),
      child: Container(
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
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  RemoveButton(
                    message: 'Fechar',
                    onTap: Navigator.of(context).pop,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
