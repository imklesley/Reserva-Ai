import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStoreBase with _$LoginStore;

abstract class _LoginStoreBase with Store {

  @observable
  String email = '';

  // ignore: use_setters_to_change_properties
  @action
  void setEmail(String value) {
    email = value;
  }

  @observable
  String password = '';

  // ignore: use_setters_to_change_properties
  @action
  void setPassword(String value) {
    password = value;
  }

  @observable
  bool obscureText = true;

  @action
  void toggleObscureText() {
    obscureText = !obscureText;
  }

}
