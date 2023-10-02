import 'package:ansicolor/ansicolor.dart';
import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';
import 'package:plataforma_rede_campo/helpers/extensions.dart';
import 'package:plataforma_rede_campo/models/user.dart';
import 'package:plataforma_rede_campo/repositories/user_repository.dart';

/*Comando queprecisa executar no terminal:
flutter packages pub run build_runner watch
flutter pub run build_runner watch --delete-conflicting-outputs
*/

part 'register_store.g.dart';

AnsiPen greenPen = AnsiPen()..green();

class RegisterStore = _RegisterStore with _$RegisterStore;

abstract class _RegisterStore with Store {
  @observable
  String? name = '';

  @action
  void setName(String? value) => name = value;

  @computed
  bool get nameValid => name != null && name!.length >= 5;
  String? get nameError {
    if (!exibirErros || nameValid) {
      return null;
    } else if (name!.isEmpty) {
      return 'Campo obrigatório';
    } else if (name!.length < 5) {
      return "Nome muito curto";
    } else {
      return ('Nome invalido');
    }
  }

  @observable
  String? email = '';

  @action
  void setEmail(String? value) => email = value;

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
  String? idadeText = '';

  @action
  void setIdadeText(String? value) => idadeText = value;

  @computed
  num? get idade {
    return num.tryParse(idadeText!);
  }

  bool get idadeValid => idade != null && idade! > 0 && idade! <= 100;
  String? get idadeError {
    if (!exibirErros || idadeValid) {
      return null;
    } else if (idadeText!.isEmpty) {
      return 'Campo obrigatório';
    } else {
      return 'Idade inválida';
    }
  }

  @observable
  String? phone = '';

  @action
  void setPhone(String? value) => phone = value;

  @computed
  bool get phoneValid => phone != null && phone!.length >= 14;

  String? get phoneError {
    if (!exibirErros || phoneValid) {
      return null;
    } else if (phone!.isEmpty) {
      return 'Campo obrigatório';
    } else {
      return 'Telefone inválido';
    }
  }

  @computed
  bool get isFormValid => nameValid && emailValid && passwordValid && idadeValid && phoneValid;

  @computed
  dynamic get cadastrarPressed => (isFormValid && !loading) ? _signUp : null;

  @observable
  bool exibirErros = false;

  @action
  void invalidSendPressed() => exibirErros = true;

  @observable
  bool loading = false;

  @action
  void setLoading(bool value) => loading = value;

  @observable
  String? error;

  @action
  void setError(String? value) => error = value;

  @observable
  bool signUpSuccess = false;

  @action
  void setSignUpSuccess(bool value) => signUpSuccess = value;

  @action
  void resetPage() {
    setName('');
    setEmail('');
    setPassword('');
    setIdadeText('');
    setPhone('');
    setError(null);
    setSignUpSuccess(false);
    exibirErros = false;
  }

  Future<void> _signUp() async {
    setLoading(true);
    setError(null);

    final user = User(name: name!, email: email!, password: password, phone: phone!, type: UserType.PESQUISADOR);

    try {
      if (kDebugMode) {
        print(user);
      }
      await UserRepository().signUpPesquisador(user);
      if (kDebugMode) {
        print(greenPen('Usuario Cadastrado'));
      }
      setSignUpSuccess(true);
    } catch (e) {
      setError(e.toString());
    }

    setLoading(false);
  }

  Future<void> _delete() async {
    setLoading(true);

    await Future.delayed(Duration(seconds: 4));

    setLoading(false);

    setError(null);
  }
}
