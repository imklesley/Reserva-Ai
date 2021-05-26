import 'package:mobx/mobx.dart';
import 'package:reservaai/controllers/stores/theme_store.dart';

part 'app_config_store.g.dart';

class AppConfigStore = _AppConfigStore with _$AppConfigStore;

abstract class _AppConfigStore with Store {
  
  //Configurações de temas na aplicação
  ThemeStore themeStore = ThemeStore();

  @observable
  bool isLoading = false;

  @action
  void changeLoadingState() {
    isLoading = !isLoading;
  }
}
