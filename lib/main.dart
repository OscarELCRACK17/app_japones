import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Importación de las páginas
import 'features/menu/menu_page.dart';
import 'features/menu/quiz_page.dart';
import 'features/menu/settings_page.dart';
import 'features/menu/about_page.dart';
import 'features/menu/mode_page.dart';
import 'features/menu/list_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Bloqueamos la orientación en vertical (como Duolingo)
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;

  // Función para manejar el cambio de tema
  void _toggleTheme(bool value) {
    setState(() {
      _isDarkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vocabulario Japonés',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.red,
          
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
        ),
      ),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: MenuPage(onThemeChanged: _toggleTheme),
      routes: {
        '/quiz': (context) => QuizPage(
              onThemeChanged: _toggleTheme,
              isDarkMode: _isDarkMode,
            ),
        '/settings': (context) => SettingsPage(
              onThemeChanged: _toggleTheme,
              isDarkMode: _isDarkMode,
            ),
        '/about': (context) => AboutPage(
              onThemeChanged: _toggleTheme,
              isDarkMode: _isDarkMode,
            ),
        '/mode': (context) => ModePage(
              onThemeChanged: _toggleTheme,
              isDarkMode: _isDarkMode,
            ),
        '/list': (context) => ListPage(
              onThemeChanged: _toggleTheme,
              isDarkMode: _isDarkMode,
            ),
         '/menu': (context) => MenuPage(onThemeChanged: _toggleTheme),     
      },
    );
  }
}
