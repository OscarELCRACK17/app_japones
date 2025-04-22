import 'package:flutter/material.dart';
import 'package:app_japones/core/utils/app_colors.dart';

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

    bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    bool hideFooter = screenHeight < 480 || screenWidth < 300;
    bool isCompact = screenHeight < 640;

    double imageHeight = isCompact ? screenHeight * 0.15 : screenHeight * 0.18;
    double imageWidth = imageHeight / 0.6;

    // Ajustamos el tamaño de los botones dependiendo de la orientación
    double buttonWidth = isLandscape ? screenWidth * 0.35 : screenWidth * 0.6;  // Más pequeño en horizontal
    double maxButtonWidth = 350.0;

    if (buttonWidth > maxButtonWidth) {
      buttonWidth = maxButtonWidth;
    }

    double buttonHeight = isCompact ? screenHeight * 0.06 : screenHeight * 0.08;
    double titleFontSize = isCompact ? screenHeight * 0.04 : screenHeight * 0.05;
    double spacing = isCompact ? 8.0 : 16.0;
    
    // Reducimos el espacio entre los botones en modo horizontal
    double buttonSpacing = 6.0;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '日本語学ぶ',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        
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
                          // Contenedor de la imagen de la bandera
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.getBorderColor(context), width: 4), // Usando el método correcto
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
                          // Título central
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              '日本語学ぶ',
                              style: TextStyle(
                                fontSize: titleFontSize,
                                fontWeight: FontWeight.bold,
                                color: AppColors.getTitleColor(context), // Usando el método correcto
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: spacing),
                          // Los botones del menú se organizan dependiendo de la orientación y tamaño de la pantalla
                          isLandscape && screenWidth < 900
                              ? Wrap(
                                  spacing: buttonSpacing,  // Espacio horizontal entre los botones
                                  runSpacing: buttonSpacing,  // Espacio vertical entre los botones
                                  alignment: WrapAlignment.center,
                                  children: [
                                    _buildButton(context, 'Play', '/quiz', buttonWidth, buttonHeight),
                                    _buildButton(context, 'Mode', '/mode', buttonWidth, buttonHeight),
                                    _buildButton(context, 'List', '/list', buttonWidth, buttonHeight),
                                    _buildButton(context, 'About', '/about', buttonWidth, buttonHeight),
                                    _buildButton(context, 'Settings', '/settings', buttonWidth, buttonHeight),
                                  ],
                                )
                              : Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    _buildButton(context, 'Play', '/quiz', buttonWidth, buttonHeight),
                                    SizedBox(height: buttonSpacing),
                                    _buildButton(context, 'Mode', '/mode', buttonWidth, buttonHeight),
                                    SizedBox(height: buttonSpacing),
                                    _buildButton(context, 'List', '/list', buttonWidth, buttonHeight),
                                    SizedBox(height: buttonSpacing),
                                    _buildButton(context, 'About', '/about', buttonWidth, buttonHeight),
                                    SizedBox(height: buttonSpacing),
                                    _buildButton(context, 'Settings', '/settings', buttonWidth, buttonHeight),
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
                          child: Row(children: _buildThemeToggle()),  // Mostrar el toggle para cambiar el tema
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: _buildThemeToggle(),  // Mostrar el toggle para cambiar el tema
                        );
                },
              ),
            ),
      floatingActionButton: hideFooter
          ? Container(
              padding: EdgeInsets.only(left: 12, top: 12),
              alignment: Alignment.topLeft,  // Establecer la posición en la parte superior izquierda
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
            widget.onThemeChanged(value);  // Llamar al callback para cambiar el tema
          });
        },
      ),
    ];
  }

  // Método para construir un botón del menú con tamaño, color y estilo
  Widget _buildButton(BuildContext context, String text, String route, double width, double height) {
    Color buttonColor = AppColors.getButtonColorByName(context, text);
    Color borderColor = _isDarkMode ? AppColors.getBorderColor(context) : AppColors.getBorderColor(context); // Usando el método correcto
     Color textColor = text == 'Settings' ? Colors.white : AppColors.getTextColor(context);

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
          fontSize: height * 0.3,  // Tamaño del texto en relación al alto del botón
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }
}
