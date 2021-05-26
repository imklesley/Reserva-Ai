import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageRepository {
  static Future<String?> uploadData(String destination, Uint8List data,
      [String? filename, SettableMetadata? settableMetadata]) async {
    try {
      final UploadTask task = FirebaseStorage.instance
          .ref(destination)
          .child(filename ?? Timestamp.now().microsecondsSinceEpoch.toString())
          .putData(data,
              settableMetadata ?? SettableMetadata(contentType: 'image/jpeg'));

      //Aguarda a task de inserção ser finalizada
      final TaskSnapshot taskSnapshot = await task;
      //Ao finalizar pega a url ao finalizar
      final String url = await taskSnapshot.ref.getDownloadURL();
      return url;
    } catch (error) {
      return null;
    }
  }
}
