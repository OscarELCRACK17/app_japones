import 'package:flutter/material.dart';

class QuizPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preguntas'),
      ),
      body: Center(
        child: Text(
          'Aquí estarán las preguntas del quiz',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
