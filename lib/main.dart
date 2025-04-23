import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

// Importación de las páginas
import 'features/menu/menu_page.dart';
import 'features/menu/quiz_page.dart';
import 'features/menu/settings_page.dart';
import 'features/menu/about_page.dart';
import 'features/menu/mode_page.dart';
import 'features/menu/list_page.dart';

// Importa tu LocaleProvider
import 'core/utils/locale_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Bloquear orientación vertical (como Duolingo)
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    ChangeNotifierProvider(
      create: (_) => LocaleProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;

  // Función para cambiar el tema
  void _toggleTheme(bool value) {
    setState(() {
      _isDarkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Obtener el LocaleProvider desde el contexto
    final localeProvider = Provider.of<LocaleProvider>(context);

    return MaterialApp(
      title: 'Vocabulario Japonés',
      debugShowCheckedModeBanner: false,

      // Temas claro y oscuro
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

      // Internacionalización
      locale: localeProvider.locale, // Usamos el idioma desde el LocaleProvider
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,

      // Página de inicio
      home: MenuPage(onThemeChanged: _toggleTheme),

      // Rutas
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
