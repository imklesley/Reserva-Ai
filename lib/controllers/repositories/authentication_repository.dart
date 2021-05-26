import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:twitter_login/entity/auth_result.dart';
import 'package:twitter_login/twitter_login.dart';

const String successCode = 'success';

class AuthenticationRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  User? get currentUser => _auth.currentUser;

  final GoogleSignIn _googleAuth = GoogleSignIn();

  final FacebookAuth _facebookAuth = FacebookAuth.instance;

  Future<void> signOut() async {
    await _googleAuth.signOut();
    await _facebookAuth.logOut();
    await _auth.signOut();
  }

  void recoverPassword({required String email}) {
    _auth.sendPasswordResetEmail(email: email);
  }

  // EMAIL AND PASSWORD
  Future<String> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return successCode;
    } on FirebaseAuthException catch (error) {
      return error.code;
    }
  }

  Future<String> signUpWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return successCode;
    } on FirebaseAuthException catch (error) {
      return error.code;
    }
  }

  //GOOGLE

  Future<String> signInSignUpWithGoogle() async {
    //Para não ter que ficar fazendo signIn o tempo toodo com o Google é guardado o user em cache, log verifica-se se o usuário já existe

    if (kIsWeb) {
      //Isso serve para fazer o pop-up que irá no google fazer o login, ao invés de tentar login direto como no mobile
      final GoogleAuthProvider _authProvider = GoogleAuthProvider();

      try {
        final UserCredential userCredential =
            await _auth.signInWithPopup(_authProvider);
        return successCode;
      } on FirebaseAuthException catch (error) {
        //TODO: tratar erros
        print('Google Login/Register Code Error: ${error.code}');
        return error.code;
      }
    } else {
      //Solicito uma conta do google, aguardo o usuário e salvo em
      // "googleSignInAccount" -- BASTA ISSO PRA FAZER O LOGIN COM O GOOGLE,
      // PORÉM É PRECISO FAZER O LOGIN COM O FIREBASE COM ESSAS CREDENCIAIS
      final GoogleSignInAccount? googleSignInAccount =
          await _googleAuth.signIn();

      //Caso seja nulo é pq o user fechou a tela, e não é possível continuar
      if (googleSignInAccount == null) {
        return 'popup-closed-by-user';
      }

      //Gera as credenciais para colocarmos no firebase
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      //Agora precisamos autenticar no firebase para isso usamos o provider do google e passamos o idToken e o acessToken que conseguimos pelo o GoogleSignInAuthentication
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      try {
        //Agora vamos logar no firebase --  ESSE MÉTODO ABAIXO SERVE PARA TODOS OS PROVIDER GOOGLE, FACEBOOK, GITHUB ETC
        final UserCredential userCredential =
            await _auth.signInWithCredential(authCredential);
        return successCode;
      } on FirebaseAuthException catch (error) {
        print('Google Login/Register Code Error: ${error.code}');
        return error.code;
      }
    }
  }

//FACEBOOK

  Future<String> signInSignUpWithFacebook() async {
    //Inicia processo de login no facebook
    final LoginResult result = await _facebookAuth.login();
    //TODO: Tratar cada caso devidamente.
    switch (result.status) {
      case LoginStatus.success:
        final AccessToken accessToken = result.accessToken!;

        //Agora precisamos autenticar no firebase
        final AuthCredential authCredential =
            FacebookAuthProvider.credential(accessToken.token);

        try {
          //Agora vamos autenticar no firebase
          final UserCredential userCredential =
              await _auth.signInWithCredential(authCredential);
          return successCode;
        } on FirebaseAuthException catch (error) {
          print('Facebook Login Code Error: ${error.code}');
          return error.code;
        }
      case LoginStatus.cancelled:
        return 'cancelled';
      case LoginStatus.failed:
        return 'failed';
      default:
        return 'server-error';
    }
  }

//TWITTER

  Future<String> signInSignUpWithTwitter() async {
    if (kIsWeb) {
      //Isso serve para fazer o pop-up que irá no google fazer o login, ao invés de tentar login direto como no mobile
      final TwitterAuthProvider _authProvider = TwitterAuthProvider();

      try {
        final UserCredential userCredential =
            await _auth.signInWithPopup(_authProvider);
        return successCode;
      } on FirebaseAuthException catch (error) {
        //TODO: tratar erros
        print('Twitter Login/Register Code Error: ${error.code}');
        return error.code;
      }
    } else {
      //TODO: Inserir após ter a conta de dev do twitter
      final twitterLogin = TwitterLogin(
        redirectURI: 'https://reservaai2021.firebaseapp.com/__/auth/handler',
        apiKey: '<your consumer key>',
        apiSecretKey: '<your consumer secret>',
      );

      //Inicia o processo de
      final AuthResult result = await twitterLogin.login();

      switch (result.status) {
        case TwitterLoginStatus.loggedIn:
          // Cria-se uma credencial via o token de acesso
          final twitterAuthCredential = TwitterAuthProvider.credential(
            accessToken: result.authToken!,
            secret: result.authTokenSecret!,
          );
          // Once signed in, return the UserCredential
          await _auth.signInWithCredential(twitterAuthCredential);
          return successCode;
        case TwitterLoginStatus.cancelledByUser:
          return 'cancelled';
        case TwitterLoginStatus.error:
          return 'failed';
        default:
          return 'server-error';
      }
    }
  }
}
