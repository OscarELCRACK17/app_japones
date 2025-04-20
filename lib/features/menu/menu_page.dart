import 'package:flutter/material.dart';

// Define la clase principal de la página MenuPage, que es un StatefulWidget.
class MenuPage extends StatefulWidget {
  final Function(bool) onThemeChanged;

  MenuPage({required this.onThemeChanged}); // Constructor que recibe una función para cambiar el tema

  @override
  _MenuPageState createState() => _MenuPageState();  // Crea el estado de la página
}

// Define el estado de la clase MenuPage.
class _MenuPageState extends State<MenuPage> {
  bool _isDarkMode = false;  // Variable que maneja el estado del tema oscuro

  @override
  Widget build(BuildContext context) {
    // Obtener el tamaño de la pantalla para hacer el diseño adaptable
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Verifica si la pantalla es pequeña (usualmente para dispositivos móviles)
    bool isCompact = screenHeight < 640;

    // Tamaños proporcionales para imagen, botones y fuentes dependiendo del tamaño de la pantalla
    double imageHeight = isCompact ? screenHeight * 0.15 : screenHeight * 0.18;
    double imageWidth = imageHeight / 0.6;  // Ajuste para la relación de aspecto de la imagen

    double buttonWidth = screenWidth * 0.7;  // El ancho del botón será el 70% del ancho de la pantalla
    double buttonHeight = isCompact ? screenHeight * 0.06 : screenHeight * 0.08;  // Ajuste de alto de botones dependiendo del tamaño de la pantalla
    double maxButtonWidth = 350.0;  // Ancho máximo de los botones
    if (buttonWidth > maxButtonWidth) buttonWidth = maxButtonWidth;  // Si el ancho excede el máximo, ajustarlo

    double titleFontSize = isCompact ? screenHeight * 0.04 : screenHeight * 0.05;  // Ajuste de tamaño de fuente para el título
    double spacing = isCompact ? 8.0 : 16.0;  // Espaciado entre los elementos dependiendo del tamaño de la pantalla
    double buttonSpacing = isCompact ? 6.0 : 12.0;  // Espaciado entre botones

    return Scaffold(
      // Barra superior de la aplicación (AppBar)
      appBar: AppBar(
        title: Text(
          '日本語学ぶ',  // Título en japonés
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),  // Estilo del título
        ),
        centerTitle: true,  // Centra el título en la barra
        backgroundColor: Colors.red,  // Color de fondo de la barra
      ),
      body: Container(
      color: Colors.blue,
          child: SingleChildScrollView(  // Permite desplazamiento si el contenido no cabe en pantalla
            child: Center(  // Asegura que todo el contenido se mantenga centrado
              child: Padding(
                padding: const EdgeInsets.all(16.0),  // Padding alrededor del contenido
                child: Column(
                  
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,  // Distribuye los elementos de manera uniforme
                  crossAxisAlignment: CrossAxisAlignment.center,  // Asegura que todo esté centrado horizontalmente
                  children: [
                    // Contenedor para la imagen de la bandera
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 4),  // Borde de la imagen
                        borderRadius: BorderRadius.circular(12),  // Bordes redondeados
                      ),
                      child: Image.asset(
                        'assets/images/flag_japan.png',  // Ruta de la imagen
                        width: imageWidth,  // Ancho de la imagen
                        height: imageHeight,  // Alto de la imagen
                        fit: BoxFit.cover,  // Asegura que la imagen se recorte correctamente
                      ),
                    ),
                    SizedBox(height: spacing),  // Espaciado entre la imagen y el título

                    // Título de la página (en japonés)
                    FittedBox(
                      fit: BoxFit.scaleDown,  // Escala el texto para que no se desborde
                      child: Text(
                        '日本語学ぶ',  // Texto del título
                        style: TextStyle(
                          fontSize: titleFontSize,  // Tamaño del texto
                          fontWeight: FontWeight.bold,  // Estilo en negrita
                        ),
                        textAlign: TextAlign.center,  // Alineación centrada
                      ),
                    ),
                    SizedBox(height: spacing),  // Espaciado entre el título y los botones

                    // Column con los botones
                    Column(
                      mainAxisSize: MainAxisSize.min,  // Minimiza el tamaño de la columna para ajustarse al contenido
                      children: [
                        _buildButton(context, 'Play', '/quiz', Colors.red, buttonWidth, buttonHeight),  // Botón "Play"
                        SizedBox(height: buttonSpacing),  // Espaciado entre botones
                        _buildButton(context, 'Mode', '/mode', Colors.green, buttonWidth, buttonHeight),  // Botón "Mode"
                        SizedBox(height: buttonSpacing),
                        _buildButton(context, 'List', '/list', Colors.orange, buttonWidth, buttonHeight),  // Botón "List"
                        SizedBox(height: buttonSpacing),
                        _buildButton(context, 'About', '/about', Colors.blue, buttonWidth, buttonHeight),  // Botón "About"
                        SizedBox(height: buttonSpacing),
                        _buildButton(context, 'Settings', '/settings', Colors.black, buttonWidth, buttonHeight),  // Botón "Settings"
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),  
      bottomNavigationBar: Container(
        color: Colors.red,  // Color de fondo del footer (igual al del header)
        padding: const EdgeInsets.all(16.0),  // Padding alrededor del footer
        child: Builder(
          builder: (context) {
            final screenWidth = MediaQuery.of(context).size.width;
            final isTooNarrow = screenWidth < 126;  // Verifica si la pantalla es demasiado estrecha

            return isTooNarrow
                ? SingleChildScrollView(
                    scrollDirection: Axis.horizontal,  // Permite el desplazamiento horizontal si es necesario
                    child: Row(
                      children: [
                        Icon(
                          _isDarkMode ? Icons.nights_stay : Icons.wb_sunny,  // Icono para el modo oscuro
                          color: _isDarkMode ? Colors.white : Colors.black,
                        ),
                        SizedBox(width: 10),
                        Switch(
                          value: _isDarkMode,  // Controla el estado del interruptor
                          onChanged: (bool value) {
                            setState(() {
                              _isDarkMode = value;  // Cambia el estado del tema
                              widget.onThemeChanged(value);  // Llama a la función que cambia el tema
                            });
                          },
                        ),
                      ],
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.start,  // Alineación de los elementos en el footer
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
                  );
          },
        ),
      ),
    );
  }

  // Función para construir los botones
  Widget _buildButton(BuildContext context, String text, String route, Color color, double width, double height) {
    Color buttonColor = _isDarkMode && text == 'Settings' ? Colors.transparent : color;  // Condicional para color de fondo
    Color borderColor = _isDarkMode && text == 'Settings' ? Colors.white : color;  // Condicional para el borde
    Color textColor = Colors.white;  // Color del texto en los botones

    return ElevatedButton(
      onPressed: () => Navigator.pushNamed(context, route),  // Navegar a la ruta correspondiente al hacer clic
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        side: BorderSide(color: borderColor, width: 2),
        minimumSize: Size(width, height),  // Tamaño mínimo de los botones
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),  // Bordes redondeados
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: height * 0.3,  // Tamaño del texto proporcional al tamaño del botón
          fontWeight: FontWeight.bold,  // Estilo en negrita
          color: textColor,  // Color del texto
        ),
      ),
    );
  }
}
