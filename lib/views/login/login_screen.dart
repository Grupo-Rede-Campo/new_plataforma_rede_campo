import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:plataforma_rede_campo/components/rounded_left_button.dart';
import 'package:plataforma_rede_campo/stores/login_store.dart';
import '../../components/error_box.dart';
import '../../components/newHeader/custom_navigation_bar.dart';
import 'components/alert_dialog_email_send.dart';
import 'components/bar_button.dart';
import 'components/navigation_button.dart';
import 'components/title_text_form.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginStore loginStore = LoginStore();
  late ReactionDisposer disposer;

  @override
  void initState() {
    super.initState();

    disposer = reaction((_) => loginStore.recoverPasswordSuccess, (s) {
      if (s == true) {
        showDialog(
          context: context,
          builder: (context) => const AlertDialogEmailSend(),
        ).then(
          (value) => loginStore.setEsqueceuSenha(),
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
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(
          double.infinity,
          size.height * 0.10,
        ),
        child: CustomNavigationBar(),
      ),
      backgroundColor: Colors.transparent,
      body: ListView(
        children: [
          //NewNavigationBarra(),
          SizedBox(
            height: size.height - (size.height * 0.1),
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/backgroundLoginScreen.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      "Rede Campo",
                      style: TextStyle(
                        fontFamily: 'Chillax',
                        fontSize: 37,
                        fontWeight: FontWeight.w700,
                        color: Color.fromRGBO(120, 231, 33, 1),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: size.width < 600
                          ? size.width
                          : size.width < 901
                              ? size.width * .7
                              : size.width * .4,
                    ),
                    //width: 970,
                    child: Card(
                      //margin: EdgeInsets.symmetric(horizontal: 400),
                      color: const Color.fromRGBO(52, 61, 67, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Observer(
                        builder: (context) => Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Stack(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 20,
                                    left: size.width < 901 ? 16 : 30,
                                    right: size.width < 901 ? 16 : 30,
                                    bottom: 30,
                                  ),
                                  child: (!loginStore.esqueceuSenha)
                                      ? Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 30),
                                              child: Observer(
                                                builder: (context) => Row(
                                                  children: [
                                                    BarButton(
                                                      label: 'Pesquisador',
                                                      color: loginStore.typeLogin == TypeLogin.PESQUISADOR
                                                          ? const Color.fromRGBO(120, 230, 33, 1)
                                                          : const Color.fromRGBO(217, 217, 217, 1),
                                                      onTap: () {
                                                        loginStore.setTypeLogin(TypeLogin.PESQUISADOR.index);
                                                      },
                                                    ),
                                                    BarButton(
                                                      label: 'Administrador',
                                                      color: loginStore.typeLogin == TypeLogin.ADMINISTRADOR
                                                          ? const Color.fromRGBO(120, 230, 33, 1)
                                                          : const Color.fromRGBO(217, 217, 217, 1),
                                                      onTap: () {
                                                        loginStore.setTypeLogin(TypeLogin.ADMINISTRADOR.index);
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 30,
                                            ),
                                            const TitleTextForm(
                                              title: "EMAIL",
                                            ),
                                            Observer(
                                              builder: (context) => TextFormField(
                                                style: const TextStyle(fontSize: 25),
                                                onChanged: loginStore.setEmail,
                                                keyboardType: TextInputType.emailAddress,
                                                enabled: !loginStore.loading,
                                                decoration: InputDecoration(
                                                  errorText: loginStore.emailError,
                                                  filled: true,
                                                  isDense: true,
                                                  fillColor: const Color.fromRGBO(239, 231, 231, 1),
                                                  border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(7),
                                                  ),
                                                ),
                                                textInputAction: TextInputAction.next,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 17,
                                            ),
                                            const TitleTextForm(
                                              title: "SENHA",
                                            ),
                                            Observer(
                                              builder: (context) => TextFormField(
                                                style: const TextStyle(fontSize: 25),
                                                onChanged: loginStore.setPassword,
                                                obscureText: true,
                                                enabled: !loginStore.loading,
                                                decoration: InputDecoration(
                                                  errorText: loginStore.passwordError,
                                                  filled: true,
                                                  isDense: true,
                                                  fillColor: const Color.fromRGBO(239, 231, 231, 1),
                                                  border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(7),
                                                  ),
                                                ),
                                                textInputAction: TextInputAction.next,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Wrap(
                                              alignment: WrapAlignment.spaceBetween,
                                              crossAxisAlignment: WrapCrossAlignment.center,
                                              spacing: 10,
                                              runSpacing: 10,
                                              children: [
                                                Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Observer(
                                                      builder: (context) => Theme(
                                                        data: Theme.of(context).copyWith(
                                                          unselectedWidgetColor: const Color.fromRGBO(217, 217, 217, 1),
                                                        ),
                                                        child: Checkbox(
                                                          value: loginStore.manterConectado,
                                                          onChanged: (_) {
                                                            loginStore.setManterConectado();
                                                          },
                                                          hoverColor: const Color.fromRGBO(217, 217, 217, 1),
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(3),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    const Text(
                                                      "Mantenha-me conectado",
                                                      style: TextStyle(
                                                        fontFamily: 'Chillax',
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.w700,
                                                        color: Color.fromRGBO(255, 255, 255, 1),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    loginStore.setEsqueceuSenha();
                                                  },
                                                  child: const Text(
                                                    "Esqueceu sua senha?",
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                      fontFamily: 'Chillax',
                                                      fontSize: 13,
                                                      fontWeight: FontWeight.w700,
                                                      color: Color.fromRGBO(255, 255, 255, 1),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Observer(
                                              builder: (context) => Container(
                                                margin: loginStore.error != null ? const EdgeInsets.only(top: 20, bottom: 20) : const EdgeInsets.only(top: 40),
                                                child: ErrorBox(
                                                  message: loginStore.error,
                                                ),
                                              ),
                                            ),
                                            Center(
                                              child: Observer(
                                                builder: (context) => FractionallySizedBox(
                                                  widthFactor: .45,
                                                  child: SizedBox(
                                                    height: 45,
                                                    child: GestureDetector(
                                                      onTap: loginStore.invalidSendPressed,
                                                      child: ElevatedButton(
                                                        onPressed: loginStore.loginPressed,
                                                        style: ElevatedButton.styleFrom(
                                                          backgroundColor: const Color.fromRGBO(237, 179, 29, 1),
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(8),
                                                          ),
                                                        ),
                                                        child: loginStore.loading
                                                            ? const CircularProgressIndicator(
                                                                color: Color.fromRGBO(246, 245, 244, 1),
                                                              )
                                                            : const Text(
                                                                "LOGIN",
                                                                style: TextStyle(
                                                                  fontFamily: 'SF Pro Display',
                                                                  fontSize: 18,
                                                                  fontWeight: FontWeight.w800,
                                                                  color: Color.fromRGBO(255, 255, 255, 1),
                                                                ),
                                                              ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      : Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(right: 30),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                      right: 10,
                                                      //top: 35,
                                                    ),
                                                    child: RoundedLeftButton(
                                                      onTap: () {
                                                        loginStore.setEsqueceuSenha();
                                                      },
                                                    ),
                                                  ),
                                                  BarButton(
                                                    label: 'Recuperação de acesso',
                                                    color: const Color.fromRGBO(120, 230, 33, 1),
                                                    onTap: null,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(40, 20, 40, 30),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: const [
                                                  Icon(
                                                    Icons.error_outline,
                                                    color: Colors.white,
                                                    size: 40,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      'Insira abaixo o seu e-mail de login e em seguida acesse o e-mail para prosseguir com o passo de recuperação de acesso.',
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w600,
                                                        color: Color.fromRGBO(239, 231, 231, 1),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const TitleTextForm(title: 'E-MAIL'),
                                            Observer(
                                              builder: (context) => TextFormField(
                                                style: const TextStyle(fontSize: 25),
                                                onChanged: loginStore.setEmail,
                                                keyboardType: TextInputType.emailAddress,
                                                enabled: !loginStore.loading,
                                                decoration: InputDecoration(
                                                  errorText: loginStore.emailError,
                                                  filled: true,
                                                  isDense: true,
                                                  fillColor: const Color.fromRGBO(239, 231, 231, 1),
                                                  border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(7),
                                                  ),
                                                ),
                                                textInputAction: TextInputAction.next,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 17,
                                            ),
                                            const TitleTextForm(title: 'CONFIRME SEU E-MAIL'),
                                            Observer(
                                              builder: (context) => TextFormField(
                                                style: const TextStyle(fontSize: 25),
                                                onChanged: loginStore.setEmail2,
                                                keyboardType: TextInputType.emailAddress,
                                                enabled: !loginStore.loading,
                                                decoration: InputDecoration(
                                                  errorText: loginStore.email2Error,
                                                  filled: true,
                                                  isDense: true,
                                                  fillColor: const Color.fromRGBO(239, 231, 231, 1),
                                                  border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(7),
                                                  ),
                                                ),
                                                textInputAction: TextInputAction.done,
                                              ),
                                            ),
                                            Observer(
                                              builder: (context) => Container(
                                                margin: loginStore.error != null ? const EdgeInsets.only(top: 20, bottom: 20) : const EdgeInsets.only(top: 40),
                                                child: ErrorBox(
                                                  message: loginStore.error,
                                                ),
                                              ),
                                            ),
                                            Center(
                                              child: Observer(
                                                builder: (context) => FractionallySizedBox(
                                                  widthFactor: .45,
                                                  child: SizedBox(
                                                    height: 45,
                                                    child: GestureDetector(
                                                      onTap: loginStore.invalidSendPressed,
                                                      child: ElevatedButton(
                                                        onPressed: loginStore.recoverPasswordPressed,
                                                        style: ElevatedButton.styleFrom(
                                                          backgroundColor: const Color.fromRGBO(61, 139, 230, 1),
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(8),
                                                          ),
                                                        ),
                                                        child: loginStore.loading
                                                            ? const CircularProgressIndicator(
                                                                color: Color.fromRGBO(246, 245, 244, 1),
                                                              )
                                                            : const Text(
                                                                "Recuperar senha",
                                                                style: TextStyle(
                                                                  fontFamily: 'SF Pro Display',
                                                                  fontSize: 18,
                                                                  fontWeight: FontWeight.w800,
                                                                  color: Color.fromRGBO(255, 255, 255, 1),
                                                                ),
                                                              ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                ),
                                /*if (loginStore.esqueceuSenha)
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 48,
                                        top: 57,
                                      ),
                                      child: RoundedLeftButton(
                                        onTap: () {
                                          loginStore.setEsqueceuSenha();
                                        },
                                      ),
                                    ),
                                  ),*/
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                /*Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: const EdgeInsets.only(
                      left: 14,
                      top: 30,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        NavigationButton(
                          label: 'Home',
                          onTap: () {},
                        ),
                        NavigationButton(
                          label: 'Noticias',
                          onTap: () {},
                        ),
                        NavigationButton(
                          label: 'Projetos',
                          onTap: () {},
                        ),
                        NavigationButton(
                          label: 'Painel',
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                )*/
              ],
            ),
          ),
        ],
      ),
    );
  }
}
