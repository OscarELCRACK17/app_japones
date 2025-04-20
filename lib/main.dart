import 'package:flutter/material.dart';
import 'features/menu/menu_page.dart'; // Asegúrate de importar correctamente las páginas
import 'features/menu/quiz_page.dart';
import 'features/menu/settings_page.dart';
import 'features/menu/about_page.dart';
import 'features/menu/mode_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false; // Estado del modo oscuro

  // Función para manejar el cambio de tema
  void _toggleTheme(bool value) {
    setState(() {
      _isDarkMode = value; // Cambiar el valor del tema
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vocabulario Japonés',
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(), // Cambiar el tema según _isDarkMode
      home: MenuPage(onThemeChanged: _toggleTheme), // Pasar la función que cambia el tema
      routes: {
        '/quiz': (context) => QuizPage(),
        '/settings': (context) => SettingsPage(),
        '/about': (context) => AboutPage(),
        '/mode': (context) => ModePage(),
      },
    );
  }
}
