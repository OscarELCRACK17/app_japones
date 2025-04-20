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
    double maxWidth = 200.0;  // Aumentamos el valor máximo, si lo deseas, ajusta el valor
    double imageWidth = screenWidth * 0.5;  // Ahora la bandera ocupará el 50% del ancho de la pantalla

    if (imageWidth > maxWidth) imageWidth = maxWidth;  // Aseguramos que no supere el valor máximo
    double imageHeight = imageWidth * 0.6;  // Mantener la proporción (60% de la imagenWidth)


    // Tamaño de los botones
    double buttonWidth = screenWidth * 0.7;  // 70% del ancho de la pantalla
    double buttonHeight = 60.0;  // Altura fija de 60
    double maxButtonWidth = 400.0; // Ancho máximo para los botones

    // Limitar el tamaño de los botones
    buttonWidth = buttonWidth > maxButtonWidth ? maxButtonWidth : buttonWidth;

    TextStyle titleStyle = TextStyle(fontSize: 32, fontWeight: FontWeight.bold);  // Estilo para el título en el AppBar

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '日本語学ぶ',
          style: titleStyle,  // Usar el estilo más pequeño aquí
        ),
        centerTitle: true,
        backgroundColor: Colors.red,  // Rojo como color principal
      ),
      body: Stack(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: Center(  // Centro del contenido para mantener la alineación
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Contenedor de la bandera
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
                          SizedBox(height: 30),
                          // Título con FittedBox
                          FittedBox(
                            fit: BoxFit.fitWidth,  // Ajusta el texto para que ocupe todo el espacio disponible
                            child: Text(
                              '日本語学ぶ',
                              style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: 40),
                          // Botones con colores representativos de Japón
                          _buildButton(context, 'Play', '/quiz', Colors.red, buttonWidth, buttonHeight),
                          SizedBox(height: 10),
                          _buildButton(context, 'Mode', '/mode', Colors.green, buttonWidth, buttonHeight),
                          SizedBox(height: 10),
                          _buildButton(context, 'About', '/about', Colors.blue, buttonWidth, buttonHeight),
                          SizedBox(height: 10),
                          _buildButton(context, 'Settings', '/settings', Colors.black, buttonWidth, buttonHeight),
                          SizedBox(height: 80), // Espacio adicional para evitar solapamientos
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          Positioned(
            bottom: 16,
            left: 16,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text, String route, Color color, double width, double height) {
    // Si estamos en modo oscuro, el fondo de "Settings" es transparente, y los demás botones tienen fondo sólido
    Color buttonColor = _isDarkMode && text == 'Settings' ? Colors.transparent : color;

    // En modo claro, todos los botones tienen fondo sólido con su color representativo
    if (!_isDarkMode && text == 'Settings') {
      buttonColor = color;
    }

    // Determinar el color del borde según el modo
    Color borderColor = _isDarkMode && text == 'Settings' ? Colors.white : color; // Borde blanco en modo oscuro, color real en modo claro
    Color textColor = _isDarkMode ? Colors.white : Colors.white; // Texto blanco siempre para buena visibilidad

    return ElevatedButton(
      onPressed: () => Navigator.pushNamed(context, route),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18, // Tamaño de la fuente
          fontWeight: FontWeight.bold, // Hacemos el texto más fuerte
          color: textColor, // El color del texto siempre blanco
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor, // Fondo transparente solo en "Settings" en modo oscuro
        side: BorderSide(color: borderColor, width: 2), // Borde con color dependiendo del modo
        minimumSize: Size(width, height),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
