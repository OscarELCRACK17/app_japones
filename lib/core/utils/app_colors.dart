import 'package:flutter/material.dart';

class AppColors {
  // Colores para el modo claro
  static const Color primaryColorLight = Colors.red;
  static const Color secondaryColorLight = Colors.green;
  static const Color accentColorLight = Colors.orange;
  static const Color infoColorLight = Colors.blue;
  static const Color textColorLight = Colors.black;
  static const Color backgroundColorLight = Colors.white;

  // Colores para el modo oscuro
  static const Color primaryColorDark = Colors.redAccent;
  static const Color secondaryColorDark = Colors.greenAccent;
  static const Color accentColorDark = Colors.orangeAccent;
  static const Color infoColorDark = Colors.blueAccent;
  static const Color textColorDark = Colors.white;
  static const Color backgroundColorDark = Colors.black;

  // Colores adicionales
  static const Color appBarColorLight = Colors.blue;
  static const Color appBarColorDark = Colors.blueAccent;

  static const Color borderColorLight = Colors.black; // Border en modo claro (negro)
  static const Color borderColorDark = Colors.white; // Border en modo oscuro (blanco)

  static const Color buttonColorLight = Colors.green;
  static const Color buttonColorDark = Colors.greenAccent;

  static const Color titleColorLight = Colors.black;
  static const Color titleColorDark = Colors.white;

  // Método para obtener los colores según el modo actual
  static Color getPrimaryColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? primaryColorDark
        : primaryColorLight;
  }

  static Color getSecondaryColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? secondaryColorDark
        : secondaryColorLight;
  }

  static Color getAccentColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? accentColorDark
        : accentColorLight;
  }

  static Color getInfoColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? infoColorDark
        : infoColorLight;
  }

  static Color getTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? textColorDark
        : textColorLight;
  }

  static Color getBackgroundColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? backgroundColorDark
        : backgroundColorLight;
  }

  // Métodos adicionales para acceder a los nuevos colores que has agregado
  static Color getAppBarColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? appBarColorDark
        : appBarColorLight;
  }

  static Color getBorderColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? borderColorDark
        : borderColorLight;
  }

  static Color getButtonColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? buttonColorDark
        : buttonColorLight;
  }

  static Color getTitleColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? titleColorDark
        : titleColorLight;
  }

  // Colores individuales por botón, dependiendo del nombre y del modo
  static Color getButtonColorByName(BuildContext context, String name) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    switch (name) {
      case 'Play':
        return isDark ? Colors.red : Colors.redAccent;
      case 'Mode':
        return isDark ? Colors.green : Colors.greenAccent;
      case 'List':
        return isDark ? Colors.orange : Colors.orangeAccent;
      case 'About':
        return isDark ? Colors.blue : Colors.blueAccent;
      case 'Settings':
        return isDark ? Colors.black : Colors.black;
      default:
        return getButtonColor(context); // Usa el color por defecto si no coincide
    }
  }
}
