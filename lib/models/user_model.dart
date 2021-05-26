import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:reservaai/models/contact_model.dart';

class UserModel {
  late Timestamp accountCreated;
  late Timestamp? birthDate;
  late ContactModel? contact;
  late String? cpf;
  late String email;
  late String? gender;
  late Timestamp lastAccess;
  late GeoPoint? location;
  late String name;
  late String profilePicture;
  late Map<String, dynamic> settings;

  UserModel(
      {required this.accountCreated,
      required this.birthDate,
      required this.contact,
      required this.cpf,
      required this.email,
      required this.gender,
      required this.lastAccess,
      required this.location,
      required this.name,
      required this.profilePicture,
      required this.settings});

  UserModel.fromJson(Map<String, dynamic> json) {
    accountCreated = json["account_created"] as Timestamp;
    birthDate = json['birth_date'] == null ? null : json['birth_date'] as Timestamp;
    if (json['contact'] != null) {
      contact = ContactModel.fromJson(json['contact'] as Map<String, dynamic>);
    }
    cpf = json['cpf'] == null ? null : json['cpf'] as String;
    email = json['email'] as String;
    gender = json['gender'] == null ? null:json['gender'] as String;
    lastAccess = json['last_access'] as Timestamp;
    location = json['location'] == null ? null : json['location'] as GeoPoint;
    name = json['name'] as String;
    profilePicture = json['profile_picture'] as String;
    //TODO: isso aqui vai virar uma classe tbm, porém como ainda n tem nada certo vai se manter String
    settings = json['settings'] as Map<String, dynamic>;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['account_created'] = accountCreated;
    data['birth_date'] = birthDate;
    data['contact'] = contact == null ? null: contact!.toJson();
    data['cpf'] = cpf;
    data['email'] = email;
    data['gender'] = gender;
    data['last_access'] = lastAccess;
    data['location'] = location;
    data['name'] = name;
    data['profile_picture'] = profilePicture;
    data['settings'] = settings;
    return data;
  }

  @override
  String toString() {
    return 'User(name: $name, cpf: $cpf, email:$email, gender: $gender)';
  }
}
