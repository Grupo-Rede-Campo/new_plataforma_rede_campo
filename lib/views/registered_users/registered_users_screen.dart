import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:plataforma_rede_campo/stores/registered_users_store.dart';
import 'package:plataforma_rede_campo/views/registered_users/components/registered_user_tile.dart';
import '../../components/bottom panel/botton panel.dart';
import '../../components/custom_navigation_bar/custom_navigation_bar.dart';
import '../../components/empty_search_dialog.dart';
import '../../components/pagination_buttons_section.dart';
import '../../components/search_field.dart';
import '../../components/title_page.dart';

class RegisteredUsersScreen extends StatelessWidget {
  RegisteredUsersScreen({Key? key}) : super(key: key);

  final RegisteredUsersStore registeredUsersStore = RegisteredUsersStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                const TitlePage(title: 'Usuários cadastrados'),
                SearchField(
                  hintText: 'Pesquisar usuários...',
                  onPressed: (String? text) {
                    registeredUsersStore.setSearch(text);
                  },
                ),
                Observer(
                  builder: (context) {
                    if (registeredUsersStore.error != null) {
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
                              "Ocorreu um erro! ${registeredUsersStore.error!}",
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
                    if (registeredUsersStore.loading) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 100),
                          child: CircularProgressIndicator(
                            color: Color.fromRGBO(37, 66, 43, 0.8),
                          ),
                        ),
                      );
                    }
                    if (registeredUsersStore.userList.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 100),
                        child: EmptySearchDialog(
                          message: 'Nenhum usuário foi encontrado!',
                        ),
                      );
                    }
                    return SizedBox(
                      width: 630,
                      child: Column(
                        children: [
                          ListView.builder(
                            itemCount: registeredUsersStore.userList.length,
                            shrinkWrap: true,
                            padding: const EdgeInsets.only(
                              top: 100,
                            ),
                            itemBuilder: (context, index) => RegisteredUserTile(user: registeredUsersStore.userList[index]),
                          ),
                          PaginationButtonSection(
                            page: registeredUsersStore.page,
                            numberItens: registeredUsersStore.numberItens,
                            itemsPerPage: 10,
                            visiblePages: 5,
                            setPage: (int page) {
                              registeredUsersStore.setPage(page);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                )
              ],
            ),
          ),
          const BottonPanel(),
        ],
      ),
    );
  }
}
