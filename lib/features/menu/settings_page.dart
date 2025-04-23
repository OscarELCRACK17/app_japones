import 'package:flutter/material.dart';
import 'package:provider/provider.dart';  // Importar provider
import 'package:app_japones/core/utils/locale_provider.dart'; // Importar el LocaleProvider
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsPage extends StatefulWidget {
  final Function(bool)? onThemeChanged;
  final bool isDarkMode;

  const SettingsPage({this.onThemeChanged, this.isDarkMode = false, Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late bool _isDarkMode;
  bool _soundEnabled = true;
  double _fontSize = 16.0;
  late String _selectedLanguage;

  final List<String> _languages = ['English', 'Español', '日本語'];

  @override
  void initState() {
    super.initState();
    _isDarkMode = widget.isDarkMode;
    
    // Obtener el idioma actual desde LocaleProvider
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);
    _selectedLanguage = _getLanguageName(localeProvider.languageCode);
  }

  // Método para convertir el código del idioma a un nombre legible
  String _getLanguageName(String languageCode) {
    switch (languageCode) {
      case 'es':
        return 'Español';
      case 'ja':
        return '日本語';
      default:
        return 'English';
    }
  }

  @override
  Widget build(BuildContext context) {
    final appLoc = AppLocalizations.of(context)!;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final bool hideFooter = screenHeight < 480 || screenWidth < 300;

    double maxWidth = screenWidth * 0.95;
    if (maxWidth > 600) maxWidth = 600;
    double maxHeight = screenHeight > 800 ? 800 : screenHeight;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          '日本語学ぶ',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: maxWidth,
            maxHeight: maxHeight,
          ),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            color: _isDarkMode ? Colors.grey[850] : Colors.white,
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                children: [
                  Text(
                    appLoc.settings,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: _isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  const Divider(),

                  // Language setting
                  ListTile(
                    leading: const Icon(Icons.language),
                    title: Text(appLoc.language),
                    trailing: DropdownButton<String>(
                      value: _selectedLanguage,
                      dropdownColor: _isDarkMode ? Colors.grey[800] : null,
                      items: _languages.map((lang) {
                        return DropdownMenuItem(
                          value: lang,
                          child: Text(lang),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          if (value != null) {
                            _selectedLanguage = value;
                            // Cambiar el idioma utilizando LocaleProvider
                            Locale newLocale;
                            switch (value) {
                              case 'Español':
                                newLocale = Locale('es');
                                break;
                              case '日本語':
                                newLocale = Locale('ja');
                                break;
                              default:
                                newLocale = Locale('en');
                            }

                            // Cambiar el idioma a través del LocaleProvider
                            Provider.of<LocaleProvider>(context, listen: false)
                                .setLocale(newLocale);
                          }
                        });
                      },
                    ),
                  ),
                  const Divider(),

                  // Sound toggle
                  SwitchListTile(
                    title: Text(appLoc.sound),
                    secondary: const Icon(Icons.volume_up),
                    value: _soundEnabled,
                    onChanged: (bool value) {
                      setState(() {
                        _soundEnabled = value;
                      });
                    },
                  ),
                  const Divider(),

                  // Font size
                  ListTile(
                    leading: const Icon(Icons.text_fields),
                    title: Text(appLoc.fontSize),
                    subtitle: Slider(
                      min: 12.0,
                      max: 24.0,
                      divisions: 6,
                      value: _fontSize,
                      label: _fontSize.toStringAsFixed(0),
                      onChanged: (value) {
                        setState(() {
                          _fontSize = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: hideFooter
          ? null
          : Container(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: _buildThemeToggle(),
              ),
            ),
      floatingActionButton: hideFooter
          ? Container(
              padding: const EdgeInsets.only(left: 12, top: 12),
              alignment: Alignment.bottomLeft,
              child: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    _isDarkMode = !_isDarkMode;
                    widget.onThemeChanged?.call(_isDarkMode);
                  });
                },
                backgroundColor: Colors.transparent,
                elevation: 0,
                child: Icon(
                  _isDarkMode ? Icons.nights_stay : Icons.wb_sunny,
                  color: _isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            )
          : null,
    );
  }

  List<Widget> _buildThemeToggle() {
    return [
      Icon(
        _isDarkMode ? Icons.nights_stay : Icons.wb_sunny,
        color: _isDarkMode ? Colors.white : Colors.black,
      ),
      const SizedBox(width: 10),
      Switch(
        value: _isDarkMode,
        onChanged: (bool value) {
          setState(() {
            _isDarkMode = value;
            widget.onThemeChanged?.call(value);
          });
        },
      ),
    ];
  }
}
