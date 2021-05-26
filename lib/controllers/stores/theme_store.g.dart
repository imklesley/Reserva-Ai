// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ThemeStore on _ThemeStore, Store {
  Computed<Mode>? _$currentThemeRadioComputed;

  @override
  Mode get currentThemeRadio => (_$currentThemeRadioComputed ??= Computed<Mode>(
          () => super.currentThemeRadio,
          name: '_ThemeStore.currentThemeRadio'))
      .value;

  final _$themeModeAtom = Atom(name: '_ThemeStore.themeMode');

  @override
  ThemeMode get themeMode {
    _$themeModeAtom.reportRead();
    return super.themeMode;
  }

  @override
  set themeMode(ThemeMode value) {
    _$themeModeAtom.reportWrite(value, super.themeMode, () {
      super.themeMode = value;
    });
  }

  final _$_ThemeStoreActionController = ActionController(name: '_ThemeStore');

  @override
  void setThemeMode(ThemeMode mode) {
    final _$actionInfo = _$_ThemeStoreActionController.startAction(
        name: '_ThemeStore.setThemeMode');
    try {
      return super.setThemeMode(mode);
    } finally {
      _$_ThemeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
themeMode: ${themeMode},
currentThemeRadio: ${currentThemeRadio}
    ''';
  }
}
