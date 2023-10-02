import 'dart:ui';
import 'package:ansicolor/ansicolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:get_it/get_it.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:plataforma_rede_campo/repositories/user_repository.dart';
import 'package:plataforma_rede_campo/stores/user_manager_store.dart';
import 'package:plataforma_rede_campo/theme/app_theme.dart';
import 'package:plataforma_rede_campo/utils/app_routes.dart';
import 'package:plataforma_rede_campo/views/about-us/about_screen.dart';
import 'package:plataforma_rede_campo/views/all_news/all_news_screen.dart';
import 'package:plataforma_rede_campo/views/articles/articles_screen.dart';
import 'package:plataforma_rede_campo/views/book_chapter/book_chapter_screen.dart';
import 'package:plataforma_rede_campo/views/books/books_screen.dart';
import 'package:plataforma_rede_campo/views/create_article/create_article_screen.dart';
import 'package:plataforma_rede_campo/views/create_book/create_book_screen.dart';
import 'package:plataforma_rede_campo/views/create_book_chapter/create_book_chapter_screen.dart';
import 'package:plataforma_rede_campo/views/create_news/create_news_screen.dart';
import 'package:plataforma_rede_campo/views/create_project/create_project_screen.dart';
import 'package:plataforma_rede_campo/views/home/home_screen.dart';
import 'package:plataforma_rede_campo/views/home_screen_admin/home_screen_admin.dart';
import 'package:plataforma_rede_campo/views/home_screen_pesquisador/home_screen_pesquisador.dart';
import 'package:plataforma_rede_campo/views/login/login_screen.dart';
import 'package:plataforma_rede_campo/views/news/news_screen.dart';
import 'package:plataforma_rede_campo/views/projects/extension_projects_screen.dart';
import 'package:plataforma_rede_campo/views/projects/innovation_and_technology_projects_screen.dart';
import 'package:plataforma_rede_campo/views/projects/research_projects_screen.dart';
import 'package:plataforma_rede_campo/views/register/register_screen.dart';
import 'package:plataforma_rede_campo/views/registered_users/registered_users_screen.dart';
import 'package:plataforma_rede_campo/views/who_we_are/who_we_are_screen.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';

void setupLocators() {
  GetIt.I.registerSingleton(UserManagerStore());
}

AnsiPen greenPen = AnsiPen()..green();

Future<void> main() async {
  setUrlStrategy(PathUrlStrategy());
  WidgetsFlutterBinding.ensureInitialized();
  //inicializando o ParseServer
  await inicializeParse();
  //chamar a funcao setupLocators() para que os objetos contidos nela possam ser acessados de qualquer local do app
  setupLocators();
  runApp(const MyApp());
}

Future<void> inicializeParse() async {
  const appId = 'PlataformaRedeCampo';
  const serverURL = 'http://200.134.22.210:1337/parse';
  const clientKey = 'ASDS3243242351JD3125';

  await Parse().initialize(
    appId,
    serverURL,
    clientKey: clientKey,
    autoSendSessionId: true,
    debug: true,
  );

  /*final categoria = ParseObject('cat')..set('tit', 'roupa');

  final response = await categoria.save();

  print(response.success);*/

  /* final User user = User(
    name: 'sasdd',
    email: 'lucasevandro15@hotmail.com',
    password: '123456',
    phone: '45988224000',
    type: UserType.PESQUISADOR,
  );

  final User user2 = await UserRepository().signUp(user);*/

  await UserRepository().loginWithEmail('lucasevandro11@hotmail.com', '123456');

  /*
  Project project = Project();
  project.title = 'titulo';
  project.description = 'descrição';

  ProjectRepository().saveProject(project);*/

  /*Field field = Field(id: 'SP3wDbxSav', areaCnpq: 'areaCnpq', description: 'description');
  News news = News(title: 'Noticia2', description: 'Teste2', field: field);

  await NewsRepository().saveNews(news);

  var allNews = NewsRepository().getAllNews();*/

  /*
  final user = User(id: 'O0x4Ydhmaz', name: 'name', email: 'email', phone: 'phone', type: UserType.PESQUISADOR);
  UserRepository().enableOrDisableUser(user: user, disable: true);
  */
  //list = await NewsRepository().getAllNews(page: 0);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch, PointerDeviceKind.stylus, PointerDeviceKind.unknown},
      ),
      title: "Plataforma Rede Campo",
      debugShowCheckedModeBanner: false,
      supportedLocales: const [
        Locale('pt', 'BR'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      theme: AppTheme.defaultTheme,
      routes: {
        AppRoutes.HOME_SCREEN: (_) => BooksScreen(),
        AppRoutes.LOGIN_SCREEN: (_) => LoginScreen(),
        AppRoutes.HOME_SCREEN_ADMIN: (_) => const HomeScreenAdmin(),
        AppRoutes.HOME_SCREEN_PESQUISADOR: (_) => const HomeScreenPesquisador(),
        AppRoutes.REGISTER_SCREEN: (_) => const RegisterScreen(),
        AppRoutes.ALL_NEWS_SCREEN: (_) => AllNewsScreen(),
        AppRoutes.CREATE_NEWS_SCREEN: (_) => CreateNewsScreen(),
        AppRoutes.NEWS_SCREEN: (_) => const NewsScreen(),
        AppRoutes.BOOKS_SCREEN: (_) => BooksScreen(),
        AppRoutes.CREATE_BOOK_SCREEN: (_) => CreateBookScreen(),
        AppRoutes.BOOK_CHAPTER_SCREEN: (_) => BookChapterScreen(),
        AppRoutes.CREATE_BOOK_CHAPTER_SCREEN: (_) => const CreateBookChapterScreen(),
        AppRoutes.ARTICLES_SCREEN: (_) => ArticlesScreen(),
        AppRoutes.CREATE_ARTICLE_SCREEN: (_) => const CreateArticleScreen(),
        AppRoutes.EXTENSION_PROJECTS_SCREEN: (_) => ExtensionProjectsScreen(),
        AppRoutes.INNOVATION_AND_TECHNOLOGY_PROJECTS_SCREEN: (_) => InnovationAndTechnologyProjectsScreen(),
        AppRoutes.RESEARCH_PROJECTS_SCREEN: (_) => ResearchProjectsScreen(),
        AppRoutes.CREATE_PROJECT_SCREEN: (_) => CreateProjectScreen(),
        AppRoutes.REGISTERED_USERS_SCREEN: (_) => RegisteredUsersScreen(),
        AppRoutes.WHO_WE_ARE_SCREEN: (_) => const WhoWeAreScreen(),
        AppRoutes.ABOUT_SCREEN: (_) => AboutScreen(),
      },
      builder: (context, child) => ResponsiveWrapper.builder(
        ClampingScrollWrapper.builder(context, child!),
        defaultScale: true,
        /*maxWidth: 1920,
        minWidth: 1920,*/
        breakpoints: const [
          ResponsiveBreakpoint.autoScale(350, name: MOBILE),
          ResponsiveBreakpoint.resize(600, name: TABLET),
          ResponsiveBreakpoint.resize(901, name: DESKTOP),
          ResponsiveBreakpoint.autoScale(1700, name: 'XL'),
        ],
      ),
    );
  }
}
