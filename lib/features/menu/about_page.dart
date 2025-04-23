import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Importa las localizaciones

class AboutPage extends StatefulWidget {
  final Function(bool)? onThemeChanged;
  final bool isDarkMode;

  const AboutPage({this.onThemeChanged, this.isDarkMode = false, Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  late bool _isDarkMode;

  @override
  void initState() {
    super.initState();
    _isDarkMode = widget.isDarkMode;
  }

  @override
  Widget build(BuildContext context) {
    final appLoc = AppLocalizations.of(context)!;  // Accede a las traducciones
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final bool hideFooter = screenHeight < 480 || screenWidth < 300;

    // Factor de escala del texto
    double textScaleFactor = MediaQuery.textScaleFactorOf(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '日本語学ぶ',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double maxWidth = screenWidth * 0.95;
          if (maxWidth > 600) maxWidth = 600;

          double maxHeight = screenHeight > 800 ? 800 : screenHeight;

          return Center(
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
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildAboutSection(appLoc.about, appLoc.aboutDescription, textScaleFactor),
                        _buildDivider(),
                        _buildSimpleTextSection(appLoc.version, textScaleFactor),
                        _buildDivider(),
                        _buildSimpleTextSection(appLoc.developer, textScaleFactor),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
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

  // Método para construir una sección con título y descripción
  Widget _buildAboutSection(String title, String description, double textScaleFactor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 24 * textScaleFactor,
            fontWeight: FontWeight.bold,
            color: _isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        SizedBox(height: 10),
        Text(
          description,
          style: TextStyle(
            fontSize: 16 * textScaleFactor,
            color: _isDarkMode ? Colors.white70 : Colors.black87,
          ),
        ),
      ],
    );
  }

  // Método para crear una sección de texto sin descripción adicional
  Widget _buildSimpleTextSection(String text, double textScaleFactor) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16 * textScaleFactor,
        fontWeight: FontWeight.bold,
        color: _isDarkMode ? Colors.white : Colors.black,
      ),
    );
  }

  // Método para crear el Divider
  Widget _buildDivider() {
    return Divider(
      color: _isDarkMode ? Colors.white24 : Colors.black12,
    );
  }
}
