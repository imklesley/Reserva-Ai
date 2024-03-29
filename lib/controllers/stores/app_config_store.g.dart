// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_config_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AppConfigStore on _AppConfigStore, Store {
  final _$isLoadingAtom = Atom(name: '_AppConfigStore.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$_AppConfigStoreActionController =
      ActionController(name: '_AppConfigStore');

  @override
  void changeLoadingState() {
    final _$actionInfo = _$_AppConfigStoreActionController.startAction(
        name: '_AppConfigStore.changeLoadingState');
    try {
      return super.changeLoadingState();
    } finally {
      _$_AppConfigStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading}
    ''';
  }
}
