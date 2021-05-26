import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_store.g.dart';

const themeModePreference = 'themeMode';
//Tipo utilizado no SharedPreferences e no RadioButtons na View
enum Mode { system, light, dark }

class ThemeStore = _ThemeStore with _$ThemeStore;

abstract class _ThemeStore with Store {
  _ThemeStore() {
    loadThemePreferences();
  }

  @observable
  ThemeMode themeMode = ThemeMode.system;

  //Somente para os Radios na view
  @computed
  Mode get currentThemeRadio {
    if (themeMode == ThemeMode.system) {
      return Mode.system;
    } else if (themeMode == ThemeMode.light) {
      return Mode.light;
    } else {
      return Mode.dark;
    }
  }

  @action
  void setThemeMode(ThemeMode mode) {
    themeMode = mode;
    saveThemePreferences();
  }

  Future<void>  saveThemePreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(themeModePreference, themeMode.toString());
  }

  Future<void> loadThemePreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey(themeModePreference)) {
      final String? themeModePrefs = prefs.getString(themeModePreference);

      if (ThemeMode.system.toString() == themeModePrefs) {
        themeMode = ThemeMode.system;
      } else if (ThemeMode.light.toString() == themeModePrefs) {
        themeMode = ThemeMode.light;
      } else {
        themeMode = ThemeMode.dark;
      }
    } else {
      themeMode = ThemeMode.system;
    }
  }
}
