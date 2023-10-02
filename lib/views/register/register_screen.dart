import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobx/mobx.dart';
import 'package:plataforma_rede_campo/components/bottom%20panel/botton%20panel.dart';
import 'package:plataforma_rede_campo/components/home_button.dart';
import 'package:plataforma_rede_campo/components/newHeader/custom_navigation_bar.dart';
import 'package:plataforma_rede_campo/stores/register_store.dart';
import 'package:plataforma_rede_campo/views/register/components/title_text_form_register.dart';
import '../../components/error_box.dart';
import '../../components/sign_out_button.dart';
import 'components/alert_dialod_sign_up_success.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  RegisterStore registerStore = RegisterStore();
  late ReactionDisposer disposer;

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController idadeController;
  late TextEditingController phoneController;

  void resetForm() {
    registerStore.resetPage();
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    idadeController.clear();
    phoneController.clear();
  }

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: registerStore.name);
    emailController = TextEditingController(text: registerStore.email);
    passwordController = TextEditingController(text: registerStore.password);
    idadeController = TextEditingController(text: registerStore.idadeText);
    phoneController = TextEditingController(text: registerStore.phone);

    disposer = reaction((_) => registerStore.signUpSuccess, (s) {
      if (s == true) {
        showDialog(
          context: context,
          builder: (context) => const AlertDialogSignUpSuccess(),
        ).then(
          (value) => registerStore.setSignUpSuccess(false),
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
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: ListView(
        children: [
          CustomNavigationBar(),
          Padding(
            padding: const EdgeInsets.only(top: 68, left: 55, right: 55),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                HomeButton(),
                SignOutButton(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 549, right: 549, bottom: 67),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset('icons/user_circle.svg'),
                const SizedBox(
                  height: 87,
                ),
                const TitleTextFormRegister(title: "Nome completo:"),
                const SizedBox(
                  height: 15,
                ),
                Observer(
                  builder: (context) => TextFormField(
                    controller: nameController,
                    //initialValue: cadastroStore.name,
                    onChanged: registerStore.setName,
                    enabled: !registerStore.loading,
                    style: const TextStyle(fontSize: 25),
                    decoration: InputDecoration(
                      errorText: registerStore.nameError,
                      isDense: true,
                      filled: true,
                      fillColor: const Color.fromRGBO(193, 193, 193, 1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                ),
                const SizedBox(
                  height: 33,
                ),
                const TitleTextFormRegister(title: "Email:"),
                const SizedBox(
                  height: 15,
                ),
                Observer(
                  builder: (context) => TextFormField(
                    controller: emailController,
                    //initialValue: cadastroStore.email,
                    onChanged: registerStore.setEmail,
                    enabled: !registerStore.loading,
                    style: const TextStyle(fontSize: 25),
                    decoration: InputDecoration(
                      errorText: registerStore.emailError,
                      isDense: true,
                      filled: true,
                      fillColor: const Color.fromRGBO(193, 193, 193, 1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                ),
                const SizedBox(
                  height: 33,
                ),
                const TitleTextFormRegister(title: "Senha:"),
                const SizedBox(
                  height: 15,
                ),
                Observer(
                  builder: (context) => TextFormField(
                    controller: passwordController,
                    //initialValue: cadastroStore.password,
                    onChanged: registerStore.setPassword,
                    enabled: !registerStore.loading,
                    style: const TextStyle(fontSize: 25),
                    decoration: InputDecoration(
                      errorText: registerStore.passwordError,
                      isDense: true,
                      filled: true,
                      fillColor: const Color.fromRGBO(193, 193, 193, 1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                ),
                const SizedBox(
                  height: 33,
                ),
                const TitleTextFormRegister(title: "Idade:"),
                const SizedBox(
                  height: 15,
                ),
                Observer(
                  builder: (context) => TextFormField(
                    controller: idadeController,
                    //initialValue: cadastroStore.idadeText,
                    onChanged: registerStore.setIdadeText,
                    enabled: !registerStore.loading,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    style: const TextStyle(fontSize: 25),
                    decoration: InputDecoration(
                      errorText: registerStore.idadeError,
                      isDense: true,
                      filled: true,
                      fillColor: const Color.fromRGBO(193, 193, 193, 1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                ),
                const SizedBox(
                  height: 33,
                ),
                const TitleTextFormRegister(title: "Telefone:"),
                const SizedBox(
                  height: 15,
                ),
                Observer(
                  builder: (context) => TextFormField(
                    controller: phoneController,
                    //initialValue: cadastroStore.phone,
                    onChanged: registerStore.setPhone,
                    enabled: !registerStore.loading,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      TelefoneInputFormatter(),
                    ],
                    style: const TextStyle(fontSize: 25),
                    decoration: InputDecoration(
                      errorText: registerStore.phoneError,
                      isDense: true,
                      filled: true,
                      fillColor: const Color.fromRGBO(193, 193, 193, 1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                Observer(
                  builder: (context) => Container(
                    margin: registerStore.error != null ? const EdgeInsets.only(top: 50, bottom: 50) : const EdgeInsets.only(top: 68),
                    child: ErrorBox(
                      message: registerStore.error,
                    ),
                  ),
                ),
                Observer(
                  builder: (context) => SizedBox(
                    height: 73,
                    width: 439,
                    child: GestureDetector(
                      onTap: registerStore.invalidSendPressed,
                      child: ElevatedButton(
                        onPressed: registerStore.cadastrarPressed,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(72, 125, 59, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 38,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'SF Pro Display',
                            color: Color.fromRGBO(246, 245, 244, 1),
                          ),
                        ),
                        child: registerStore.loading
                            ? const CircularProgressIndicator(
                                color: Color.fromRGBO(246, 245, 244, 1),
                              )
                            : const Text("Salvar alterações"),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 22,
                ),
                Observer(
                  builder: (context) => SizedBox(
                    height: 73,
                    width: 439,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(182, 60, 60, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 38,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'SF Pro Display',
                          color: Color.fromRGBO(246, 245, 244, 1),
                        ),
                      ),
                      onPressed: !registerStore.loading
                          ? () {
                              showDialog(
                                context: context,
                                builder: (context) => const AlertDialogSignUpSuccess(),
                              ).then(
                                (value) {
                                  resetForm();
                                },
                              );
                            }
                          : null,
                      child: const Text("Desativar conta"),
                    ),
                  ),
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
