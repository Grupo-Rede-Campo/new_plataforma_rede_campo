import 'package:mobx/mobx.dart';
import 'package:plataforma_rede_campo/models/project.dart';
import 'package:plataforma_rede_campo/repositories/project_repository.dart';

/*Comando queprecisa executar no terminal:
flutter packages pub run build_runner watch
flutter pub run build_runner watch --delete-conflicting-outputs
*/

part 'create_project_store.g.dart';

class CreateProjectStore = _CreateProjectStore with _$CreateProjectStore;

abstract class _CreateProjectStore with Store {
  _CreateProjectStore(this.project) {
    title = project.title ?? '';
    content = project.content ?? '';
    participants = project.participants ?? '';
    projectType = project.type;
    projectTypeCopy = project.type;
  }

  final Project project;

  @observable
  String? title = '';

  @action
  void setTitle(String? value) => title = value;

  @computed
  bool get titleValid => title!.length >= 6;
  String? get titleError {
    if (!showErrors || titleValid) {
      return null;
    } else if (title!.isEmpty) {
      return 'Campo obrigatório';
    } else {
      return 'Título muito curto';
    }
  }

  @observable
  String? content = '';

  @action
  void setContent(String? value) => content = value;

  @computed
  bool get contentValid => content!.length >= 100;
  String? get contentError {
    if (!showErrors || contentValid) {
      return null;
    } else if (content!.isEmpty) {
      return 'Campo obrigatório';
    } else {
      return 'Descrição muito curta';
    }
  }

  @observable
  String? participants = '';

  @action
  void setParticipants(String? value) => participants = value;

  @computed
  bool get participantsValid => participants!.length >= 5;
  String? get participantsError {
    if (!showErrors || participantsValid) {
      return null;
    } else if (participants!.isEmpty) {
      return 'Campo obrigatório';
    } else {
      return 'Participantes muito curto';
    }
  }

  @observable
  bool loading = false;

  @action
  void setLoading(bool value) => loading = value;

  @observable
  String? error;

  @action
  void setError(String? value) => error = value;

  @observable
  bool showErrors = false;

  @action
  void invalidSendPressed() => showErrors = true;

  @observable
  bool saveSucces = false;

  @action
  void setSaveSucces(bool value) => saveSucces = value;

  @observable
  bool deleteSucces = false;

  @action
  void setDeleteSucces(bool value) => deleteSucces = value;

  @observable
  bool changedType = false;

  @action
  void setChangedType(bool value) => changedType = value;

  @observable
  ProjectType? projectType;

  @action
  void setProjectTypePesquisa() => projectType = ProjectType.PESQUISA;

  @action
  void setProjectTypeExtensao() => projectType = ProjectType.EXTENSAO;

  @action
  void setProjectTypeInovacaoeTecnologia() => projectType = ProjectType.INOVACAOETECNOLOGIA;

  @computed
  bool get projectTypeValid => projectType != null;

  @computed
  bool get formValid => titleValid && contentValid && participantsValid && projectTypeValid;

  @observable
  ProjectType? projectTypeCopy;

  @action
  void set(ProjectType value) => projectTypeCopy = value;

  @computed
  dynamic get publicarPressed => (formValid && !loading) ? _publicar : null;

  @computed
  dynamic get deletePressed => !loading ? _deleteProject : null;

  @action
  Future<void> _publicar() async {
    setLoading(true);
    setError(null);

    try {
      project.title = title;
      project.content = content;
      project.participants = participants;
      project.type = projectType!;
      await ProjectRepository().saveProject(project);
      if (projectTypeCopy != projectType) {
        changedType = true;
      }
      setSaveSucces(true);
    } catch (e) {
      setError(e.toString());
    }

    setLoading(false);
  }

  @action
  Future<void> _deleteProject() async {
    setLoading(true);
    await ProjectRepository().delete(project: project);
    setDeleteSucces(true);
    setLoading(false);
  }
}
