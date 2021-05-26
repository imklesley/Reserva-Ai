import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:mobx/mobx.dart';
import 'package:reservaai/controllers/repositories/authentication_repository.dart';
import 'package:reservaai/controllers/repositories/firestore_repository.dart';
import 'package:reservaai/controllers/repositories/storage_repository.dart';
import 'package:reservaai/models/user_model.dart';

part 'auth_store.g.dart';

class AuthStore = _AuthStore with _$AuthStore;

const String successMessage = 'success';
const String clientsPathStorage = '/users_data/client/';

abstract class _AuthStore with Store {
  //Guarda o estado da execução relacionada com auth
  @observable
  bool isLoading = false;

  //Realiza todas as operações de autenticação no Firebase
  final FirestoreRepository _firestoreRepository = FirestoreRepository();

  _AuthStore() {
    _authRepository = AuthenticationRepository();
    _authRepository.authStateChanges.listen((User? user) async {
      if (user == null) {
        print('User is currently signed out!');
        _loadUser();
      }else {
        print('User is signed in!');
        this.user = user;
      }
    });
  }





  //Guarda a instância de usuário autenticado ou null
  @observable
  User? user;
  
  @computed
  bool get isLoggedIn {
    return user != null;
  }

  @observable
  UserModel? userData;

  late AuthenticationRepository _authRepository;



  @action
  Future<void> signInWithEmailAndPassword(
      {required String email,
      required String password,
      required Function(String) onSuccess,
      required Function(String) onFail}) async {
    isLoading = true;

    //Realiza tentativa de cadastro
    final String resultCode = await _authRepository.signInWithEmailAndPassword(
        email: email, password: password);

    if (resultCode == successMessage) {
      //Atualiza a instancia de user (NECESSÁRIO, AUTHSTATECHANGES MT LENTO NO FLUTTER WEB)
      user = _authRepository.currentUser;

      //Todo: Fazer essa atuaização somente no login ou toda vez que o user entrar na aplicação
      //Ao logar, atualiza o campo de lastAcess
      await _getUserData();
      //Envio o primeiro nome do usuário para a view... para saldações
      onSuccess(userData!.name.split(' ').first);
      isLoading = false;
    } else {
      onFail(resultCode);
      isLoading = false;
    }
  }

  @action
  Future<void> signUpWithEmailAndPassword(
      {required Map<String, dynamic> userData,
      required String password,
      required Function(String) onSuccess,
      required Function(String) onFail}) async {
    //Avisa os listeners que o app iniciou o processo de signUp
    isLoading = true;

    //Realiza tentativa de cadastro
    final String resultCode = await _authRepository.signUpWithEmailAndPassword(
        email: userData['email'] as String, password: password);

    //Usuário
    if (resultCode == successMessage) {
      //Atualiza a instancia de user (NECESSÁRIO, AUTHSTATECHANGES MT LENTO NO FLUTTER WEB)
      user = _authRepository.currentUser;

      if (userData['profile_picture'] != null) {
        //Tentativa de upload do arquivo UInt8List de imagem
        final String? url = await StorageRepository.uploadData(
            clientsPathStorage + user!.uid,
            userData['profile_picture'] as Uint8List,
            'profile_picture');

        //Guarda a url dentro do map de dados do user
        userData['profile_picture'] = url;
      }

      await _saveUserData(userData);
      //Envio o primeiro nome do usuário para a view... para saldações
      onSuccess(userData['name'].toString().split(' ').first);
      isLoading = false;
    } else {
      onFail(resultCode);
      isLoading = false;
    }
  }

  void recoverPassword({required String email}) {
    _authRepository.recoverPassword(email: email);
  }

  @action
  Future<void> signInWithGoogle(
      {required Function(String) onSuccess,
      required Function(String) onFail}) async {
    isLoading = true;

    //Realiza tentativa de cadastro
    final String resultCode = await _authRepository.signInSignUpWithGoogle();

    if (resultCode == successMessage) {
      //Atualiza a instancia de user (NECESSÁRIO, AUTHSTATECHANGES MT LENTO NO FLUTTER WEB)
      user = _authRepository.currentUser;

      //Caso o user tenha um doc já recupera -- caso doc exista já muda o
      //isDocUserExists para true
      await _getUserData();

      //Se doc de dados do user n existe, logo cria-se e salva-se um.
      if(!_firestoreRepository.isDocUserExists){
        final Map<String,dynamic> data = {
          'account_created': Timestamp.now(),
          'birth_date': null,
          //TODO: Auth-Providers não retornam o phoneNumer por alguma razão
          'contact': null,
          'cpf': null,
          'email': user!.email,
          'gender': null,
          'last_access': Timestamp.now(),
          'location': null,
          'name': user!.displayName,
          'profile_picture': user!.photoURL,
          //Verificar quais outras configurações entram aqui
          'settings': {
            'email_subscription': true,
          }
        };
        //Salva no firestore e cria o modelo pra usar localmente
        await _saveUserData(data);
      }
      // print('dados: $userData');
      //Nome do user é enviado para view como saudações
      onSuccess(userData!.name.split(' ').first);
      isLoading = false;
    } else {
      onFail(resultCode);
      isLoading = false;
    }
  }




  @action
  Future<void> signInSignUpWithFacebook(
      {required Function(String) onSuccess,
        required Function(String) onFail}) async {
    isLoading = true;

    //Realiza tentativa de cadastro
    final String resultCode = await _authRepository.signInSignUpWithFacebook();

    if (resultCode == successMessage) {
      //Atualiza a instancia de user (NECESSÁRIO, AUTHSTATECHANGES MT LENTO NO FLUTTER WEB)
      user = _authRepository.currentUser;

      //Caso o user tenha um doc já recupera -- caso doc exista já muda o
      //isDocUserExists para true
      await _getUserData();

      //Se doc de dados do user n existe, logo cria-se e salva-se um.
      if(!_firestoreRepository.isDocUserExists){
        //TODO: Pensar em formas de como não usar tanto esse map enorme em vários lugares
        final Map<String,dynamic> data = {
          'account_created': Timestamp.now(),
          'birth_date': null,
          //TODO: Auth-Providers não retornam o phoneNumer por alguma razão
          'contact': null,
          'cpf': null,
          'email': user!.email,
          'gender': null,
          'last_access': Timestamp.now(),
          'location': null,
          'name': user!.displayName,
          'profile_picture': user!.photoURL,
          //Verificar quais outras configurações entram aqui
          'settings': {
            'email_subscription': true,
          }
        };
        //Salva no firestore e cria o modelo pra usar localmente
        await _saveUserData(data);
      }
      // print('dados: $userData');
      //Nome do user é enviado para view como saudações
      onSuccess(userData!.name.split(' ').first);
      isLoading = false;
    } else {
      onFail(resultCode);
      isLoading = false;
    }
  }




  @action
  Future<void> signInSignUpWithTwitter(
      {required Function(String) onSuccess,
        required Function(String) onFail}) async {
    isLoading = true;

    //Realiza tentativa de cadastro
    final String resultCode = await _authRepository.signInSignUpWithTwitter();

    if (resultCode == successMessage) {
      //Atualiza a instancia de user (NECESSÁRIO, AUTHSTATECHANGES MT LENTO NO FLUTTER WEB)
      user = _authRepository.currentUser;

      //Caso o user tenha um doc já recupera -- caso doc exista já muda o
      //isDocUserExists para true
      await _getUserData();

      //Se doc de dados do user n existe, logo cria-se e salva-se um.
      if(!_firestoreRepository.isDocUserExists){
        //TODO: Pensar em formas de como não usar tanto esse map enorme em vários lugares
        final Map<String,dynamic> data = {
          'account_created': Timestamp.now(),
          'birth_date': null,
          //TODO: Auth-Providers não retornam o phoneNumer por alguma razão
          'contact': null,
          'cpf': null,
          'email': user!.email,
          'gender': null,
          'last_access': Timestamp.now(),
          'location': null,
          'name': user!.displayName,
          'profile_picture': user!.photoURL,
          //Verificar quais outras configurações entram aqui
          'settings': {
            'email_subscription': true,
          }
        };
        //Salva no firestore e cria o modelo pra usar localmente
        await _saveUserData(data);
      }
      // print('dados: $userData');
      //Nome do user é enviado para view como saudações
      onSuccess(userData!.name.split(' ').first);
      isLoading = false;
    } else {
      onFail(resultCode);
      isLoading = false;
    }
  }





  @action
  void signOut() {
    //Sai da conta do usuário no firebase
    _authRepository.signOut();

    //reseta os campos locais que representam o estado de login do usuário
    //Avisa pro meu app que o usuário saiu
    user = null;
    userData = null;
  }

  //Recupera as informações do usuário no cloudfirestore
  Future<void> _getUserData() async {
    userData = await _firestoreRepository.getUserData(user!.uid);
  }

  //Salva-se os dados no firebase
  Future? _saveUserData(Map<String, dynamic> data) async {
    //Salva-se os dados no firestore e retorna o usermodel pra usar localmente
    userData = await _firestoreRepository.saveUserData(user!.uid, data);
  }

  //Carrega usuário autenticado, seja quando for feito o login ou quando o app inicializar
  Future? _loadUser() async {
    //variável user é nula? se sim passa o current user armazenado na instancia _auth
    user ??= _authRepository.currentUser;

    //Agora verifica-se se o _auth tinha algo, caso não tenha faz a solicitação dos dados ao firebase
    if (user != null) {
      // Se não for nulo e os dados estiverem vazios, buscamos os dados no firebase
      if (userData == null) {
        _getUserData();
      }
    }
  }
}
