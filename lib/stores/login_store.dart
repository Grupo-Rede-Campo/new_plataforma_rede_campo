import 'package:ansicolor/ansicolor.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:plataforma_rede_campo/helpers/extensions.dart';
import 'package:plataforma_rede_campo/repositories/user_repository.dart';
import 'package:plataforma_rede_campo/stores/user_manager_store.dart';

import '../models/user.dart';

/*Comando queprecisa executar no terminal:
flutter packages pub run build_runner watch
flutter pub run build_runner watch --delete-conflicting-outputs
*/

part 'login_store.g.dart';

AnsiPen greenPen = AnsiPen()..green();

enum TypeLogin { PESQUISADOR, ADMINISTRADOR }

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  @observable
  TypeLogin typeLogin = TypeLogin.PESQUISADOR;

  @action
  void setTypeLogin(int? value) => typeLogin = TypeLogin.values[value!];

  @observable
  String? email = '';

  @action
  void setEmail(String value) => email = value;

  @computed
  bool get emailValid => email != null && email!.isEmailValid();

  String? get emailError {
    if (!exibirErros || emailValid) {
      return null;
    } else {
      return 'E-mail invalido';
    }
  }

  @observable
  String? email2 = '';

  @action
  void setEmail2(String? value) => email2 = value;

  @computed
  bool get email2Valid => email2 != null && email == email2;
  String? get email2Error {
    if (!exibirErros || email2Valid) {
      return null;
    } else {
      return "E-mails não coincidem";
    }
  }

  @observable
  String? password = '';

  @action
  void setPassword(String value) => password = value;

  @computed
  bool get passwordValid => password != null && password!.length >= 6;

  String? get passwordError {
    if (!exibirErros || passwordValid) {
      return null;
    } else {
      return 'Senha deve ter 6 digitos';
    }
  }

  @observable
  bool passwordVisible = false;

  @action
  void setObscurePassword() => this.passwordVisible = !passwordVisible;

  @observable
  bool manterConectado = true;

  @action
  void setManterConectado() => this.manterConectado = !manterConectado;

  //para exibir os erros ou nao
  @observable
  bool exibirErros = false;

  @action
  void setExibirErros(bool value) => exibirErros = value;

  @observable
  bool loading = false;

  @action
  void setLoading(bool value) => loading = value;

  //usado para recebe a mensagem do erro que ouve erro no login
  @observable
  String? error;

  @action
  void setError(String? value) => error = value;

  @observable
  bool esqueceuSenha = false;

  @action
  void setEsqueceuSenha() => {
        this.esqueceuSenha = !esqueceuSenha,
        setExibirErros(false),
        setError(null),
        setEmail(''),
        setEmail2(''),
        setPassword(''),
      };

  @observable
  bool recoverPasswordSuccess = false;

  @action
  void setRecoverPasswordSuccess(bool value) => recoverPasswordSuccess = value;

  @action
  void invalidSendPressed() => exibirErros = true;

  @computed
  bool get isFormValid => (emailValid && passwordValid);

  @computed
  dynamic get loginPressed => (isFormValid && !loading) ? _login : null;

  @computed
  dynamic get recoverPasswordPressed => (emailValid && email2Valid && !loading) ? _recoverPassword : null;

  Future<void> _login() async {
    setLoading(true);

    setError(null);

    try {
      //tenta fazer o login se for sucesso o user vai conter todos os dados do usuario
      final User? user = await UserRepository().loginWithEmail(email!, password!);
      //faz o usuario ficar disponivel para ser acessado de qualquer local do app
      GetIt.I<UserManagerStore>().setUser(user);
      if (kDebugMode) {
        print(greenPen("Usuario Logado: $user"));
        print(greenPen("ADM: ${GetIt.I<UserManagerStore>().isLoggedAdm}"));
      }
    } catch (e) {
      setError(e.toString());
    }

    setLoading(false);
  }

  Future<void> _recoverPassword() async {
    setLoading(true);

    setError(null);

    try {
      await UserRepository().recoverPassword(email!);
      setError(null);
      setRecoverPasswordSuccess(true);
      setRecoverPasswordSuccess(false);
    } catch (e) {
      setError(e.toString());
    }

    setLoading(false);
  }
}
