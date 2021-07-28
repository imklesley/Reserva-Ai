import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reservaai/models/user_model.dart';

const String userCollectionName = 'client';

class FirestoreRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Verifica se o usuário já tem seu doc com informações
  bool isDocUserExists = false;

  Future<UserModel?> getUserData(String uid) async {
    //Sempre lembrar que esse bendito tipo do docUser tem que está completo
    //ou n consigue-se pega o map -_-
    final DocumentSnapshot<Map<String, dynamic>> docUser =
        await _firestore.collection(userCollectionName).doc(uid).get();

    if (docUser.exists) {
      isDocUserExists = true;
      return UserModel.fromJson(docUser.data()!);
    }
    else{
      isDocUserExists = false;
      return null;
    }

  }

  Future<UserModel> saveUserData(
      String uid, Map<String, dynamic> userData) async {
    //Salva-se os dados no firebase
    await _firestore.collection(userCollectionName).doc(uid).set(userData);

    //Salva-se os dados localmente tbm
    return UserModel.fromJson(userData);
  }

  Future<void> updateUserLastAccess(String uid) async {
    final dataToUpdate = <String, dynamic>{};
    dataToUpdate['last_access'] = Timestamp.now();
    await _firestore
        .collection(userCollectionName)
        .doc(uid)
        .update(dataToUpdate);
  }
}
