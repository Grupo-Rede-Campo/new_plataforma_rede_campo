import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:plataforma_rede_campo/models/article.dart';
import 'package:plataforma_rede_campo/stores/create_article_store.dart';
import '../../components/bottom panel/botton panel.dart';
import '../../components/error_box.dart';
import '../../components/home_button.dart';
import '../../components/newHeader/custom_navigation_bar.dart';
import 'components/title_text_form_create_article_screen.dart';

class CreateArticleScreen extends StatefulWidget {
  const CreateArticleScreen({Key? key, this.article}) : super(key: key);

  final Article? article;

  @override
  State<CreateArticleScreen> createState() => _CreateArticleScreenState(article: article);
}

class _CreateArticleScreenState extends State<CreateArticleScreen> {
  _CreateArticleScreenState({Article? article})
      : editing = article != null,
        createArticleStore = CreateArticleStore(article ?? Article());

  bool editing;

  CreateArticleStore createArticleStore;

  @override
  void initState() {
    when((_) => (createArticleStore.saveSucces || createArticleStore.deleteSucces), () {
      if (editing) {
        Navigator.of(context).pop(true);
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

  final InputBorder _errorBorder = const OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.red,
      width: 1,
    ),
  );

  final InputBorder _focusedErrorBorder = const OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.red,
      width: 2,
    ),
  );

  final InputBorder _border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(4),
    borderSide: BorderSide.none,
  );

  @override
  Widget build(BuildContext context) {
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
                        editing ? "Editar artigo" : 'Adicionar artigo',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 56,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 53,
                    ),
                    const TitleTextFormCreateArticleScreen(
                      title: 'Titulo',
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Observer(
                      builder: (context) => TextFormField(
                        maxLines: 1,
                        enabled: !createArticleStore.loading,
                        initialValue: createArticleStore.title,
                        onChanged: createArticleStore.setTitle,
                        style: const TextStyle(fontSize: 25),
                        decoration: InputDecoration(
                          errorText: createArticleStore.titleError,
                          filled: true,
                          fillColor: const Color.fromRGBO(217, 217, 217, 1),
                          border: _border,
                          focusedErrorBorder: _focusedErrorBorder,
                          errorBorder: _errorBorder,
                        ),
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    const SizedBox(
                      height: 75,
                    ),
                    const TitleTextFormCreateArticleScreen(
                      title: 'Resumo',
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Observer(
                      builder: (context) => TextFormField(
                        maxLines: 20,
                        enabled: !createArticleStore.loading,
                        initialValue: createArticleStore.sumary,
                        onChanged: createArticleStore.setSumary,
                        style: const TextStyle(fontSize: 25),
                        decoration: InputDecoration(
                          errorText: createArticleStore.sumaryError,
                          filled: true,
                          fillColor: const Color.fromRGBO(217, 217, 217, 1),
                          border: _border,
                          focusedErrorBorder: _focusedErrorBorder,
                          errorBorder: _errorBorder,
                        ),
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    const SizedBox(
                      height: 61,
                    ),
                    const TitleTextFormCreateArticleScreen(
                      title: 'Autores',
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Observer(
                      builder: (context) => TextFormField(
                        maxLines: 1,
                        enabled: !createArticleStore.loading,
                        initialValue: createArticleStore.authors,
                        onChanged: createArticleStore.setAuthors,
                        style: const TextStyle(fontSize: 25),
                        decoration: InputDecoration(
                          errorText: createArticleStore.authorsError,
                          filled: true,
                          fillColor: const Color.fromRGBO(217, 217, 217, 1),
                          border: _border,
                          focusedErrorBorder: _focusedErrorBorder,
                          errorBorder: _errorBorder,
                        ),
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    const SizedBox(
                      height: 61,
                    ),
                    const TitleTextFormCreateArticleScreen(
                      title: 'Revista',
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Observer(
                      builder: (context) => TextFormField(
                        maxLines: 1,
                        enabled: !createArticleStore.loading,
                        initialValue: createArticleStore.publisher,
                        onChanged: createArticleStore.setPublisher,
                        style: const TextStyle(fontSize: 25),
                        decoration: InputDecoration(
                          errorText: createArticleStore.publisherError,
                          filled: true,
                          fillColor: const Color.fromRGBO(217, 217, 217, 1),
                          border: _border,
                          focusedErrorBorder: _focusedErrorBorder,
                          errorBorder: _errorBorder,
                        ),
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    const SizedBox(
                      height: 61,
                    ),
                    const TitleTextFormCreateArticleScreen(
                      title: 'Ano',
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Observer(
                      builder: (context) => TextFormField(
                        maxLines: 1,
                        enabled: !createArticleStore.loading,
                        initialValue: createArticleStore.yearText,
                        onChanged: createArticleStore.setYearText,
                        style: const TextStyle(fontSize: 25),
                        decoration: InputDecoration(
                          errorText: createArticleStore.yearError,
                          filled: true,
                          fillColor: const Color.fromRGBO(217, 217, 217, 1),
                          border: _border,
                          focusedErrorBorder: _focusedErrorBorder,
                          errorBorder: _errorBorder,
                        ),
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    const SizedBox(
                      height: 61,
                    ),
                    const TitleTextFormCreateArticleScreen(
                      title: 'DOI',
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Observer(
                      builder: (context) => TextFormField(
                        maxLines: 1,
                        enabled: !createArticleStore.loading,
                        initialValue: createArticleStore.doi,
                        onChanged: createArticleStore.setDoi,
                        style: const TextStyle(fontSize: 25),
                        decoration: InputDecoration(
                          errorText: createArticleStore.doiError,
                          filled: true,
                          fillColor: const Color.fromRGBO(217, 217, 217, 1),
                          border: _border,
                          focusedErrorBorder: _focusedErrorBorder,
                          errorBorder: _errorBorder,
                        ),
                        textInputAction: TextInputAction.done,
                      ),
                    ),
                    Observer(
                      builder: (context) => Container(
                        margin: createArticleStore.error != null ? const EdgeInsets.only(top: 70, bottom: 40) : const EdgeInsets.only(top: 70),
                        child: ErrorBox(
                          message: createArticleStore.error,
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
                            onTap: createArticleStore.invalidSendPressed,
                            child: ElevatedButton(
                              onPressed: createArticleStore.publicarPressed,
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
                              child: createArticleStore.loading
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
                                onPressed: createArticleStore.deletePressed,
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
