import 'package:flutter/material.dart';

class LocaleProvider with ChangeNotifier {
  Locale _locale = Locale('en'); // Idioma predeterminado

  Locale get locale => _locale;

  // Método para cambiar el idioma
  void setLocale(Locale locale) {
    if (_locale.languageCode != locale.languageCode) {  // Compara solo los códigos de idioma
      _locale = locale;
      notifyListeners();  // Notifica a los oyentes para que actualicen su UI
    }
  }

  // Método para obtener el idioma actual
  String get languageCode => _locale.languageCode;
}
