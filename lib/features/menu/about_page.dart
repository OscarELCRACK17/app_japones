import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acerca de'),
      ),
      body: Center(
        child: Text(
          'Información sobre la app y su propósito.',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
