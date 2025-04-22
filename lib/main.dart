import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/utils/orientation_lock.dart';
import 'features/menu/menu_page.dart';
import 'features/menu/quiz_page.dart';
import 'features/menu/settings_page.dart';
import 'features/menu/about_page.dart';
import 'features/menu/mode_page.dart';
import 'features/menu/list_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Bloquear orientación vertical (portrait)
  await lockPortraitOrientation();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;

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
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: MenuPage(onThemeChanged: _toggleTheme),
      routes: {
        '/quiz': (context) => QuizPage(),
        '/settings': (context) => SettingsPage(),
        '/about': (context) => AboutPage(),
        '/mode': (context) => ModePage(),
        '/list': (context) => ListPage(),
      },
    );
  }
}
