import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobx/mobx.dart';
import 'package:plataforma_rede_campo/components/bottom%20panel/botton%20panel.dart';
import 'package:plataforma_rede_campo/models/book.dart';
import 'package:plataforma_rede_campo/stores/create_book_store.dart';
import 'package:plataforma_rede_campo/views/create_book/components/title_form_create_book.dart';
import '../../components/custom_navigation_bar/custom_navigation_bar.dart';
import '../../components/error_box.dart';
import '../../components/remove_button.dart';
import '../../components/title_page.dart';

class CreateBookScreen extends StatefulWidget {
  CreateBookScreen({Key? key}) : super(key: key);

  @override
  State<CreateBookScreen> createState() => _CreateBookScreenState();
}

class _CreateBookScreenState extends State<CreateBookScreen> {
  Book? book;
  late bool editing;
  late CreateBookStore createBookStore;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    book = ModalRoute.of(context)!.settings.arguments as Book?;
    editing = book != null;
    createBookStore = CreateBookStore(book ?? Book());
    when((_) => (createBookStore.saveSucces || createBookStore.deleteSucces), () {
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
              left: 437,
              right: 437,
            ),
            child: Column(
              children: [
                TitlePage(title: editing ? 'Editar livro' : 'Adicionar livro'),
                const SizedBox(
                  height: 80,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Observer(
                      builder: (context) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: getImage,
                            child: Container(
                              width: 238,
                              height: 343,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: const Color.fromRGBO(217, 217, 217, 1.0),
                                border: createBookStore.imageError != null
                                    ? Border.all(
                                        color: Colors.red,
                                        width: 2,
                                      )
                                    : null,
                              ),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  createBookStore.image != null
                                      ? createBookStore.image is FilePickerResult
                                          ? Image.memory(
                                              createBookStore.image.files.first.bytes,
                                              fit: BoxFit.cover,
                                            )
                                          : CachedNetworkImage(
                                              imageUrl: createBookStore.image.url!,
                                              fit: BoxFit.cover,
                                            )
                                      : Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              const Text(
                                                'Adicionar',
                                                style: TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color.fromRGBO(57, 51, 51, 1),
                                                  //fontFamily: "SF Pro Text",
                                                ),
                                              ),
                                              SvgPicture.asset(
                                                'assets/icons/add.svg',
                                                height: 100,
                                              ),
                                              const Text(
                                                'imagem',
                                                style: TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color.fromRGBO(57, 51, 51, 1),
                                                  //fontFamily: "SF Pro Text",
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                  createBookStore.image != null
                                      ? Padding(
                                          padding: const EdgeInsets.all(22),
                                          child: Align(
                                            alignment: Alignment.topLeft,
                                            child: RemoveButton(
                                              message: 'Remover imagem',
                                              onTap: () {
                                                createBookStore.setImage(null);
                                              },
                                            ),
                                          ),
                                        )
                                      : Container(),
                                ],
                              ),
                            ),
                          ),
                          if (createBookStore.imageError != null)
                            Container(
                              padding: const EdgeInsets.fromLTRB(14, 7, 0, 0),
                              child: Text(
                                createBookStore.imageError!,
                                style: TextStyle(
                                  color: Colors.red.shade700,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 88,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TitleTextFormCreateBook(title: 'Título:'),
                          Observer(
                            builder: (context) => TextFormField(
                              enabled: !createBookStore.loading,
                              initialValue: createBookStore.title,
                              onChanged: createBookStore.setTitle,
                              style: const TextStyle(fontSize: 30),
                              cursorColor: const Color.fromRGBO(37, 66, 43, 1),
                              decoration: InputDecoration(
                                errorText: createBookStore.titleError,
                                isDense: true,
                                filled: true,
                                fillColor: const Color.fromRGBO(217, 217, 217, 1.0),
                                border: _border,
                                errorBorder: _errorBorder,
                                focusedErrorBorder: _focusedErrorBorder,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          const TitleTextFormCreateBook(title: 'Editora:'),
                          Observer(
                            builder: (context) => TextFormField(
                              enabled: !createBookStore.loading,
                              initialValue: createBookStore.publisher,
                              onChanged: createBookStore.setPublisher,
                              style: const TextStyle(fontSize: 30),
                              cursorColor: const Color.fromRGBO(37, 66, 43, 1),
                              decoration: InputDecoration(
                                errorText: createBookStore.publisherError,
                                isDense: true,
                                filled: true,
                                fillColor: const Color.fromRGBO(217, 217, 217, 1.0),
                                border: _border,
                                errorBorder: _errorBorder,
                                focusedErrorBorder: _focusedErrorBorder,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          const TitleTextFormCreateBook(title: 'Autores:'),
                          Observer(
                            builder: (context) => TextFormField(
                              enabled: !createBookStore.loading,
                              initialValue: createBookStore.authors,
                              onChanged: createBookStore.setAuthors,
                              style: const TextStyle(fontSize: 30),
                              cursorColor: const Color.fromRGBO(37, 66, 43, 1),
                              decoration: InputDecoration(
                                errorText: createBookStore.authorsError,
                                isDense: true,
                                filled: true,
                                fillColor: const Color.fromRGBO(217, 217, 217, 1.0),
                                border: _border,
                                errorBorder: _errorBorder,
                                focusedErrorBorder: _focusedErrorBorder,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          const TitleTextFormCreateBook(title: 'Ano:'),
                          Observer(
                            builder: (context) => TextFormField(
                              initialValue: createBookStore.yearText,
                              enabled: !createBookStore.loading,
                              onChanged: createBookStore.setYearText,
                              style: const TextStyle(fontSize: 30),
                              cursorColor: const Color.fromRGBO(37, 66, 43, 1),
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(4),
                                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                              ],
                              decoration: InputDecoration(
                                errorText: createBookStore.yearError,
                                isDense: true,
                                filled: true,
                                fillColor: const Color.fromRGBO(217, 217, 217, 1.0),
                                border: _border,
                                errorBorder: _errorBorder,
                                focusedErrorBorder: _focusedErrorBorder,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          const TitleTextFormCreateBook(title: 'Link:'),
                          Observer(
                            builder: (context) => TextFormField(
                              enabled: !createBookStore.loading,
                              initialValue: createBookStore.url,
                              onChanged: createBookStore.setUrl,
                              style: const TextStyle(fontSize: 30),
                              cursorColor: const Color.fromRGBO(37, 66, 43, 1),
                              decoration: InputDecoration(
                                errorText: createBookStore.urlError,
                                isDense: true,
                                filled: true,
                                fillColor: const Color.fromRGBO(217, 217, 217, 1.0),
                                border: _border,
                                errorBorder: _errorBorder,
                                focusedErrorBorder: _focusedErrorBorder,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Observer(
                  builder: (context) => Container(
                    margin: createBookStore.error != null ? const EdgeInsets.only(top: 50, bottom: 50) : const EdgeInsets.only(top: 68),
                    child: ErrorBox(
                      message: createBookStore.error,
                    ),
                  ),
                ),
                Observer(
                  builder: (context) => GestureDetector(
                    onTap: createBookStore.invalidSendPressed,
                    child: SizedBox(
                      height: 60,
                      width: 437,
                      child: ElevatedButton(
                        onPressed: createBookStore.savePressed,
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
                        child: createBookStore.loading
                            ? const CircularProgressIndicator(
                                color: Color.fromRGBO(246, 245, 244, 1),
                              )
                            : const Text('Publicar'),
                      ),
                    ),
                  ),
                ),
                if (editing)
                  Observer(
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
                          onPressed: createBookStore.deletePressed,
                          child: const Text("Excluir"),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const BottonPanel(),
        ],
      ),
    );
  }

  Future<void> getImage() async {
    final image = await FilePicker.platform.pickFiles(type: FileType.image);
    if (image != null) {
      createBookStore.setImage(null);
      createBookStore.setImage(image);
    }
  }
}
