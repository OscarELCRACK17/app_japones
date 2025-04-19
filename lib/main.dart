import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vocabulario Japonés',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: QuizPage(),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _score = 0;
  int _currentQuestionIndex = 0;

  // Lista de preguntas y respuestas
  List<Map<String, Object>> _questions = [
    {
      'question': '¿Cómo se dice "Perro" en japonés?',
      'answers': ['Inu', 'Neko', 'Tori', 'Umi'],
      'correctAnswer': 'Inu',
    },
    {
      'question': '¿Cómo se dice "Gato" en japonés?',
      'answers': ['Inu', 'Neko', 'Tori', 'Umi'],
      'correctAnswer': 'Neko',
    },
    {
      'question': '¿Cómo se dice "Pájaro" en japonés?',
      'answers': ['Inu', 'Neko', 'Tori', 'Umi'],
      'correctAnswer': 'Tori',
    },
  ];

  // Función para verificar la respuesta seleccionada
  void _checkAnswer(String selectedAnswer) {
    if (selectedAnswer == _questions[_currentQuestionIndex]['correctAnswer']) {
      setState(() {
        _score++;
      });
    }

    setState(() {
      _currentQuestionIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_currentQuestionIndex >= _questions.length) {
      // Mostrar resultado final
      return Scaffold(
        appBar: AppBar(
          title: Text('Resultado'),
        ),
        body: Center(
          child: Text(
            'Tu puntaje final es: $_score',
            style: TextStyle(fontSize: 24),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Vocabulario Japonés de prueba'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              _questions[_currentQuestionIndex]['question'] as String,
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ...(_questions[_currentQuestionIndex]['answers'] as List<String>).map(
              (answer) {
                return ElevatedButton(
                  onPressed: () => _checkAnswer(answer),
                  child: Text(answer),
                );
              },
            ),
            SizedBox(height: 20),
            Text(
              'Puntaje: $_score',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
