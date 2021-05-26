import 'package:flutter/material.dart';

//Contém toda a lista de localidades aceitas pelo app, deve existir arquivos de
// tradução para todas as Locales.

// ignore: avoid_classes_with_only_static_members
class L10n{
  static final all = [
    const Locale('pt','BR'),
    const Locale('en'),
    const Locale('es'),
  ];
}