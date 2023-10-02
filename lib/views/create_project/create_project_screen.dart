import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:plataforma_rede_campo/components/bottom%20panel/botton%20panel.dart';
import 'package:plataforma_rede_campo/components/newHeader/custom_navigation_bar.dart';
import 'package:plataforma_rede_campo/stores/create_project_store.dart';
import 'package:plataforma_rede_campo/views/create_project/components/title_text_form_create_project_screen.dart';
import '../../components/error_box.dart';
import '../../components/home_button.dart';
import '../../models/project.dart';
import 'components/radio_list_tile_create_project.dart';

class CreateProjectScreen extends StatefulWidget {
  CreateProjectScreen({Key? key, this.project}) : super(key: key);

  final Project? project;

  @override
  State<CreateProjectScreen> createState() => _CreateProjectScreenState(project);
}

class _CreateProjectScreenState extends State<CreateProjectScreen> {
  _CreateProjectScreenState(Project? project)
      : editing = project != null,
        createProjectStore = CreateProjectStore(project ?? Project());

  bool editing;
  CreateProjectStore createProjectStore;

  @override
  void initState() {
    when((_) => (createProjectStore.saveSucces || createProjectStore.deleteSucces), () {
      if (editing) {
        if (createProjectStore.deleteSucces) {
          Navigator.of(context).pop({
            'save': true,
            'changedType': false,
            'delete': true,
          });
        } else if (createProjectStore.changedType) {
          Navigator.of(context).pop({
            'save': true,
            'changedType': true,
            'delete': false,
          });
        } else {
          Navigator.of(context).pop({
            'save': true,
            'changedType': false,
            'delete': false,
          });
        }
      } else {
        showDialog(
          context: context,
          builder: (context) => const AlertDialog(
            title: Text('Salvo com Sucesso'),
            content: Text('Lançar uma rota...'),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: ListView(
        children: [
          CustomNavigationBar(),
          Stack(
            fit: StackFit.passthrough,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 250,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 103, bottom: 56),
                      child: Text(
                        editing ? "Editar projeto" : 'Adicionar projeto',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 56,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Observer(
                      builder: (context) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          RadioLIstTileCreateProject(
                            title: 'Projeto de pesquisa',
                            value: ProjectType.PESQUISA,
                            groupValue: createProjectStore.projectType!,
                            onChanged: createProjectStore.setProjectTypePesquisa,
                          ),
                          RadioLIstTileCreateProject(
                            title: 'Projeto de extensão',
                            value: ProjectType.EXTENSAO,
                            groupValue: createProjectStore.projectType!,
                            onChanged: createProjectStore.setProjectTypeExtensao,
                          ),
                          RadioLIstTileCreateProject(
                            title: 'Projeto de inovação e tecnólogia',
                            value: ProjectType.INOVACAOETECNOLOGIA,
                            groupValue: createProjectStore.projectType!,
                            onChanged: createProjectStore.setProjectTypeInovacaoeTecnologia,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 53,
                    ),
                    const TitleTextFormCreateProjectScreen(title: 'Titulo'),
                    const SizedBox(
                      height: 12,
                    ),
                    Observer(
                      builder: (context) => TextFormField(
                        maxLines: 1,
                        enabled: !createProjectStore.loading,
                        initialValue: createProjectStore.title,
                        onChanged: createProjectStore.setTitle,
                        style: const TextStyle(fontSize: 25),
                        decoration: InputDecoration(
                          errorText: createProjectStore.titleError,
                          filled: true,
                          fillColor: const Color.fromRGBO(217, 217, 217, 1),
                          border: createProjectStore.titleError == null
                              ? InputBorder.none
                              : const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.redAccent,
                                  ),
                                ),
                          errorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.redAccent,
                            ),
                          ),
                        ),
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    const SizedBox(
                      height: 75,
                    ),
                    const TitleTextFormCreateProjectScreen(title: 'Descrição'),
                    const SizedBox(
                      height: 12,
                    ),
                    Observer(
                      builder: (context) => TextFormField(
                        maxLines: 20,
                        enabled: !createProjectStore.loading,
                        initialValue: createProjectStore.content,
                        onChanged: createProjectStore.setContent,
                        style: const TextStyle(fontSize: 25),
                        decoration: InputDecoration(
                          errorText: createProjectStore.contentError,
                          filled: true,
                          fillColor: const Color.fromRGBO(217, 217, 217, 1),
                          border: createProjectStore.contentError == null
                              ? InputBorder.none
                              : const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.redAccent,
                                  ),
                                ),
                          errorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.redAccent,
                            ),
                          ),
                        ),
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    const SizedBox(
                      height: 61,
                    ),
                    const TitleTextFormCreateProjectScreen(title: 'Participantes'),
                    const SizedBox(
                      height: 12,
                    ),
                    Observer(
                      builder: (context) => TextFormField(
                        maxLines: 1,
                        enabled: !createProjectStore.loading,
                        initialValue: createProjectStore.participants,
                        onChanged: createProjectStore.setParticipants,
                        style: const TextStyle(fontSize: 25),
                        decoration: InputDecoration(
                          errorText: createProjectStore.participantsError,
                          filled: true,
                          fillColor: const Color.fromRGBO(217, 217, 217, 1),
                          border: createProjectStore.participantsError == null
                              ? InputBorder.none
                              : const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.redAccent,
                                  ),
                                ),
                          errorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.redAccent,
                            ),
                          ),
                        ),
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    Observer(
                      builder: (context) => Container(
                        margin: createProjectStore.error != null
                            ? const EdgeInsets.only(
                                top: 70,
                                bottom: 40,
                              )
                            : const EdgeInsets.only(
                                top: 70,
                              ),
                        child: ErrorBox(
                          message: createProjectStore.error,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Observer(
                        builder: (context) => SizedBox(
                          width: 437,
                          height: 60,
                          child: GestureDetector(
                            onTap: createProjectStore.invalidSendPressed,
                            child: ElevatedButton(
                              onPressed: createProjectStore.publicarPressed,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromRGBO(72, 125, 59, 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                textStyle: const TextStyle(
                                  fontSize: 38,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromRGBO(246, 245, 244, 1),
                                ),
                              ),
                              child: createProjectStore.loading
                                  ? const CircularProgressIndicator(
                                      color: Color.fromRGBO(246, 245, 244, 1),
                                    )
                                  : const Text("Publicar"),
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (editing)
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Observer(
                          builder: (context) => Padding(
                            padding: const EdgeInsets.only(
                              top: 20,
                            ),
                            child: SizedBox(
                              height: 60,
                              width: 437,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromRGBO(182, 60, 60, 1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  textStyle: const TextStyle(
                                    fontSize: 38,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromRGBO(246, 245, 244, 1),
                                  ),
                                ),
                                onPressed: createProjectStore.deletePressed,
                                child: const Text("Excluir"),
                              ),
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(
                      height: 67,
                    ),
                  ],
                ),
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 88,
                    left: 55,
                  ),
                  child: HomeButton(),
                ),
              ),
            ],
          ),
          const BottonPanel(),
        ],
      ),
    );
  }
}
