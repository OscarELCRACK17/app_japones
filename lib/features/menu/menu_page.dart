import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  final Function(bool) onThemeChanged;

  MenuPage({required this.onThemeChanged});

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    bool hideFooter = screenHeight < 480 || screenWidth < 300;
    bool isCompact = screenHeight < 640;
    double imageHeight = isCompact ? screenHeight * 0.15 : screenHeight * 0.18;
    double imageWidth = imageHeight / 0.6;

    double buttonWidth = screenWidth * 0.7;
    double maxButtonWidth = 350.0;

    if (screenWidth >= 600 && screenWidth < 900) {
      buttonWidth = screenWidth * 0.75;
    } else if (screenWidth >= 900 && screenWidth < 2400) {
      buttonWidth = screenWidth * 0.5;
    }

    if (buttonWidth > maxButtonWidth) {
      buttonWidth = maxButtonWidth;
    }

    double buttonHeight = isCompact ? screenHeight * 0.06 : screenHeight * 0.08;
    double titleFontSize = isCompact ? screenHeight * 0.04 : screenHeight * 0.05;
    double spacing = isCompact ? 8.0 : 16.0;
    double buttonSpacing = isCompact ? 6.0 : 12.0;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '日本語学ぶ',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),

      body: Container(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Imagen de la bandera
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 4),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Image.asset(
                              'assets/images/flag_japan.png',
                              width: imageWidth,
                              height: imageHeight,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: spacing),
                          // Título
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              '日本語学ぶ',
                              style: TextStyle(
                                fontSize: titleFontSize,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: spacing),
                          // Botones del menú
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _buildButton(context, 'Play', '/quiz', Colors.red, buttonWidth, buttonHeight),
                              SizedBox(height: buttonSpacing),
                              _buildButton(context, 'Mode', '/mode', Colors.green, buttonWidth, buttonHeight),
                              SizedBox(height: buttonSpacing),
                              _buildButton(context, 'List', '/list', Colors.orange, buttonWidth, buttonHeight),
                              SizedBox(height: buttonSpacing),
                              _buildButton(context, 'About', '/about', Colors.blue, buttonWidth, buttonHeight),
                              SizedBox(height: buttonSpacing),
                              _buildButton(context, 'Settings', '/settings', Colors.black, buttonWidth, buttonHeight),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),

      // Footer con icono + switch (si hay suficiente espacio)
      bottomNavigationBar: hideFooter
          ? null
          : Container(
              padding: const EdgeInsets.all(16.0),
              child: Builder(
                builder: (context) {
                  final screenWidth = MediaQuery.of(context).size.width;
                  final isTooNarrow = screenWidth < 126;

                  return isTooNarrow
                      ? SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(children: _buildThemeToggle()),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: _buildThemeToggle(),
                        );
                },
              ),
            ),

      // Icono + switch flotante si el footer está oculto
      floatingActionButton: hideFooter
          ? Container(
              padding: EdgeInsets.only(left: 12, top: 12),
              alignment: Alignment.topLeft,  // Establece la posición en la parte superior izquierda
              child: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    _isDarkMode = !_isDarkMode;
                    widget.onThemeChanged(_isDarkMode);
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

  // Crea lista con icono y switch reutilizable (para footer o widget flotante)
  List<Widget> _buildThemeToggle() {
    return [
      Icon(
        _isDarkMode ? Icons.nights_stay : Icons.wb_sunny,
        color: _isDarkMode ? Colors.white : Colors.black,
      ),
      SizedBox(width: 10),
      Switch(
        value: _isDarkMode,
        onChanged: (bool value) {
          setState(() {
            _isDarkMode = value;
            widget.onThemeChanged(value);
          });
        },
      ),
    ];
  }

  // Crea un botón del menú con tamaño, color y estilo
  Widget _buildButton(BuildContext context, String text, String route, Color color, double width, double height) {
    Color buttonColor = _isDarkMode && text == 'Settings' ? Colors.transparent : color;
    Color borderColor = _isDarkMode && text == 'Settings' ? Colors.white : color;
    Color textColor = Colors.white;

    return ElevatedButton(
      onPressed: () => Navigator.pushNamed(context, route),
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        side: BorderSide(color: borderColor, width: 2),
        minimumSize: Size(width, height),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: height * 0.3,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }
}
