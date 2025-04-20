import 'package:flutter/material.dart';

class ListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista'),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Text(
          'Esta es la página de la lista',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
