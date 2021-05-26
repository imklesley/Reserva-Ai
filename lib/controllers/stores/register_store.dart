import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';

part 'register_store.g.dart';

class RegisterStore = _RegisterStoreBase with _$RegisterStore;

abstract class _RegisterStoreBase with Store {

  @observable
  GeoPoint? location;

  @action
  void setLocation(GeoPoint? value){
    // print(value!.longitude);
    // print(value.latitude);
    location = value;
  }



  @observable
  String email = '';

  @action
  void setEmail(String value) {
    email = value;
  }

  @observable
  String password = '';

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

  @observable
  String name = '';

  @action
  void setName(String value) {
    name = value;
  }

  @observable
  String cpf = '';

  @action
  void setCpf(String value) {
    cpf = value;
  }

  @observable
  DateTime? birthDate;

  @action
  void setBirthDate(DateTime value) {
    birthDate = value;
  }

  @observable
  String gender = '';

  @action
  void setGender(String value) {
    gender = value;
  }

  @observable
  String phoneNumber = '';

  void setPhoneNumber(String value) {
    phoneNumber = value;
  }

  @observable
  bool isWhatsapp = true;

  @action
  void toggleIsWhatsapp() {
    isWhatsapp = !isWhatsapp;
  }

  @observable
  PickedFile? profilePicture;

  @action
  void setProfilePicture(PickedFile? value) {
    profilePicture = value;
  }
}
