import 'package:mobx/mobx.dart';
import 'package:plataforma_rede_campo/models/project.dart';
import 'package:plataforma_rede_campo/repositories/project_repository.dart';

/*Comando queprecisa executar no terminal:
flutter packages pub run build_runner watch
flutter pub run build_runner watch --delete-conflicting-outputs
*/

part 'project_store.g.dart';

class ProjectStore = _ProjectStore with _$ProjectStore;

abstract class _ProjectStore with Store {
  _ProjectStore({required this.projectType}) {
    autorun((_) async {
      setLoading(true);
      try {
        _getNumberItens(projectType: projectType);
        await _getProjects(search: search, page: page, projectType: projectType);
        setError(null);
        setLoading(false);
      } catch (e) {
        setLoading(false);
        setError(e.toString());
      }
    });
  }

  @observable
  ProjectType projectType;

  @action
  void setProjectType(ProjectType value) => projectType = value;

  @observable
  ObservableList<Project> projectsList = ObservableList<Project>();

  @observable
  String? search;

  @action
  void setSearch(String? value) {
    search = value;
    resetPage();
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
  int numberItens = 0;

  @action
  void setNumberItens(int value) => numberItens = value;

  @observable
  int page = 0;

  @action
  void setPage(int value) => page = value;

  @action
  void resetPage() {
    projectsList.clear();
    page = 0;
  }

  @action
  Future<void> _getProjects({String? search, required int page, required ProjectType projectType}) async {
    final projects = await ProjectRepository().getAllProject(
      search: search,
      page: page,
      projectType: projectType,
    );
    projectsList.clear();
    projectsList.addAll(projects);
  }

  @action
  void refesh() => _getProjects(search: search, page: page, projectType: projectType);

  @action
  Future<void> _getNumberItens({required ProjectType projectType}) async {
    int numberItens = await ProjectRepository().getCountAllProjects(search: search, projectType: projectType);
    setNumberItens(numberItens);
  }

  @action
  Future<void> deleteProject({required Project project}) async {
    setLoading(true);
    await ProjectRepository().delete(project: project);
    resetPage();
    setLoading(false);
  }
}
