import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configuraciones'),
      ),
      body: Center(
        child: Text(
          'Aquí podrás ajustar la configuración.',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
