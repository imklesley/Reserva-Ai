// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AuthStore on _AuthStore, Store {
  Computed<bool>? _$isLoggedInComputed;

  @override
  bool get isLoggedIn => (_$isLoggedInComputed ??=
          Computed<bool>(() => super.isLoggedIn, name: '_AuthStore.isLoggedIn'))
      .value;

  final _$isLoadingAtom = Atom(name: '_AuthStore.isLoading');

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

  final _$userAtom = Atom(name: '_AuthStore.user');

  @override
  User? get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(User? value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  final _$userDataAtom = Atom(name: '_AuthStore.userData');

  @override
  UserModel? get userData {
    _$userDataAtom.reportRead();
    return super.userData;
  }

  @override
  set userData(UserModel? value) {
    _$userDataAtom.reportWrite(value, super.userData, () {
      super.userData = value;
    });
  }

  final _$signInWithEmailAndPasswordAsyncAction =
      AsyncAction('_AuthStore.signInWithEmailAndPassword');

  @override
  Future<void> signInWithEmailAndPassword(
      {required String email,
      required String password,
      required dynamic Function(String) onSuccess,
      required dynamic Function(String) onFail}) {
    return _$signInWithEmailAndPasswordAsyncAction.run(() => super
        .signInWithEmailAndPassword(
            email: email,
            password: password,
            onSuccess: onSuccess,
            onFail: onFail));
  }

  final _$signUpWithEmailAndPasswordAsyncAction =
      AsyncAction('_AuthStore.signUpWithEmailAndPassword');

  @override
  Future<void> signUpWithEmailAndPassword(
      {required Map<String, dynamic> userData,
      required String password,
      required dynamic Function(String) onSuccess,
      required dynamic Function(String) onFail}) {
    return _$signUpWithEmailAndPasswordAsyncAction.run(() => super
        .signUpWithEmailAndPassword(
            userData: userData,
            password: password,
            onSuccess: onSuccess,
            onFail: onFail));
  }

  final _$signInWithGoogleAsyncAction =
      AsyncAction('_AuthStore.signInWithGoogle');

  @override
  Future<void> signInWithGoogle(
      {required dynamic Function(String) onSuccess,
      required dynamic Function(String) onFail}) {
    return _$signInWithGoogleAsyncAction.run(
        () => super.signInWithGoogle(onSuccess: onSuccess, onFail: onFail));
  }

  final _$signInSignUpWithFacebookAsyncAction =
      AsyncAction('_AuthStore.signInSignUpWithFacebook');

  @override
  Future<void> signInSignUpWithFacebook(
      {required dynamic Function(String) onSuccess,
      required dynamic Function(String) onFail}) {
    return _$signInSignUpWithFacebookAsyncAction.run(() =>
        super.signInSignUpWithFacebook(onSuccess: onSuccess, onFail: onFail));
  }

  final _$signInSignUpWithTwitterAsyncAction =
      AsyncAction('_AuthStore.signInSignUpWithTwitter');

  @override
  Future<void> signInSignUpWithTwitter(
      {required dynamic Function(String) onSuccess,
      required dynamic Function(String) onFail}) {
    return _$signInSignUpWithTwitterAsyncAction.run(() =>
        super.signInSignUpWithTwitter(onSuccess: onSuccess, onFail: onFail));
  }

  final _$_AuthStoreActionController = ActionController(name: '_AuthStore');

  @override
  void signOut() {
    final _$actionInfo =
        _$_AuthStoreActionController.startAction(name: '_AuthStore.signOut');
    try {
      return super.signOut();
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
user: ${user},
userData: ${userData},
isLoggedIn: ${isLoggedIn}
    ''';
  }
}
