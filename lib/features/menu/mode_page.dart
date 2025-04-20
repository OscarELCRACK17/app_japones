import 'package:flutter/material.dart';

class ModePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modos'),
      ),
      body: Center(
        child: Text(
          'Selecciona el modo de juego.',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
