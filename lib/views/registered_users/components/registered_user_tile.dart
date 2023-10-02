import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobx/mobx.dart';
import 'package:plataforma_rede_campo/views/registered_users/components/alert_error_activate_deactivate_user.dart';
import '../../../models/user.dart';
import '../../../stores/registered_users_tile_store.dart';

class RegisteredUserTile extends StatefulWidget {
  RegisteredUserTile({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  State<RegisteredUserTile> createState() => _RegisteredUserTileState(user: user);
}

class _RegisteredUserTileState extends State<RegisteredUserTile> {
  _RegisteredUserTileState({required User user}) : registeredUsersTileStore = RegisteredUsersTileStore(user);

  final RegisteredUsersTileStore registeredUsersTileStore;
  late ReactionDisposer disposer;

  @override
  void initState() {
    super.initState();
    disposer = reaction((_) => registeredUsersTileStore.error != null, (s) {
      if (s == true) {
        showDialog(
          context: context,
          builder: (context) => AlertErrorActiveDeactiveUser(
            message: 'Não foi possivel alterar o STATUS do usuário',
            onPressed: Navigator.of(context).pop,
          ),
        ).then(
          (value) => registeredUsersTileStore.setError(null),
        );
      }
    });
  }

  @override
  void dispose() {
    disposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 83,
      margin: const EdgeInsets.only(bottom: 50),
      padding: const EdgeInsets.symmetric(horizontal: 25),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromRGBO(8, 64, 20, 1),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          widget.user.image != null
              ? ClipOval(
                  child: SizedBox.fromSize(
                    size: const Size.fromRadius(30),
                    child: CachedNetworkImage(
                      imageUrl: widget.user.image.url,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                      errorWidget: (context, url, error) => Icon(
                        Icons.error,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                )
              : SvgPicture.asset('assets/images/sem_imagem.svg'),
          const SizedBox(
            width: 25,
          ),
          Expanded(
            child: Text(
              widget.user.name,
              style: const TextStyle(
                fontSize: 31,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Observer(builder: (context) {
            if (registeredUsersTileStore.loading) {
              return const CircularProgressIndicator(
                color: Color.fromRGBO(248, 120, 2, 0.93),
              );
            } else {
              return Switch(
                // thumb color (round icon)
                activeColor: const Color.fromRGBO(248, 120, 2, 0.93),
                activeTrackColor: const Color.fromRGBO(248, 120, 2, 0.93),
                inactiveThumbColor: const Color.fromRGBO(154, 154, 154, 1),
                inactiveTrackColor: const Color.fromRGBO(154, 154, 154, 1),
                splashRadius: 20,
                // boolean variable value
                value: !widget.user.isDisabled,
                // changes the state of the switch
                onChanged: (value) {
                  registeredUsersTileStore.toggleIsDisabled();
                },
              );
            }
          }),
        ],
      ),
    );
  }
}
