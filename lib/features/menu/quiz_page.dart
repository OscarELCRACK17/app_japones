import 'package:flutter/material.dart';
import 'package:app_japones/data/repositories/question_repository.dart';
import 'package:app_japones/data/models/question_model.dart';
import 'package:app_japones/core/utils/app_colors.dart';

class QuizPage extends StatefulWidget {
  final Function(bool)? onThemeChanged;
  final bool isDarkMode;

  const QuizPage({this.onThemeChanged, this.isDarkMode = false, Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  late bool _isDarkMode;
  late Future<List<Question>> _questions;
  int _currentQuestionIndex = 0;
  bool _answered = false;
  int _score = 0;
  String? _selectedAnswer;

  @override
  void initState() {
    super.initState();
    _isDarkMode = widget.isDarkMode;
    _questions = _loadRandomQuestions();
  }

  Future<List<Question>> _loadRandomQuestions() async {
    final allQuestions = await QuestionRepository().loadQuestions();
    allQuestions.shuffle();
    return allQuestions.take(10).toList(); // Tomamos solo 5 preguntas aleatorias
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final bool hideFooter = screenHeight < 480 || screenWidth < 300;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('日本語学ぶ',
        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.getPrimaryColor(context),
      ),
      body: FutureBuilder<List<Question>>(
        future: _questions,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
          if (snapshot.hasError) return Center(child: Text('Error al cargar las preguntas'));
          if (!snapshot.hasData || snapshot.data!.isEmpty) return Center(child: Text('No hay preguntas disponibles.'));

          final questions = snapshot.data!;
          final currentQuestion = questions[_currentQuestionIndex];

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Pregunta ${_currentQuestionIndex + 1} de ${questions.length}',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 20),
                Text(
                  currentQuestion.question,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),

                // Bloque centrado con tarjetas
                Flexible(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Center(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: 600,
                          ),
                          child: GridView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: screenHeight < 870 ? 0.9 : 1,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemCount: currentQuestion.options.length,
                            itemBuilder: (context, index) {
                              final option = currentQuestion.options[index];
                              final isCorrect = option == currentQuestion.correctAnswer;
                              final isSelected = option == _selectedAnswer;

                              Color? cardColor;
                              if (_answered) {
                                if (isCorrect) {
                                  cardColor = Colors.green.withOpacity(0.7);
                                } else if (isSelected) {
                                  cardColor = Colors.red.withOpacity(0.7);
                                }
                              }

                              return Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                color: cardColor,
                                child: InkWell(
                                  onTap: _answered
                                      ? null
                                      : () {
                                          setState(() {
                                            _answered = true;
                                            _selectedAnswer = option;
                                            if (option == currentQuestion.correctAnswer) {
                                              _score++;
                                            }
                                          });

                                          Future.delayed(Duration(seconds: 1), () {
                                            if (_currentQuestionIndex < questions.length - 1) {
                                              setState(() {
                                                _currentQuestionIndex++;
                                                _answered = false;
                                                _selectedAnswer = null;
                                              });
                                            } else {
                                              _showFinalDialog(questions); // Pasa las preguntas al método
                                            }
                                          });
                                        },
                                  child: Center(
                                    child: Text(
                                      option,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.getTextColor(context),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: hideFooter
          ? null
          : Container(
              color: AppColors.getPrimaryColor(context),
              height: MediaQuery.of(context).size.height * 0.10,
              padding: const EdgeInsets.all(16.0),
              child: Builder(
                builder: (context) {
                  final screenWidth = MediaQuery.of(context).size.width;
                  final isTooNarrow = screenWidth < 126;
                  return isTooNarrow
                      ? SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: _buildThemeToggle()))
                      : Row(mainAxisAlignment: MainAxisAlignment.start, children: _buildThemeToggle());
                },
              ),
            ),
      floatingActionButton: hideFooter
          ? Container(
              padding: EdgeInsets.only(left: 12, top: 12),
              alignment: Alignment.bottomLeft,
              child: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    _isDarkMode = !_isDarkMode;
                    widget.onThemeChanged?.call(_isDarkMode);
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

  void _showFinalDialog(List<Question> questions) {
    // Determinamos si el usuario acertó más preguntas de las que falló
    bool isVictory = _score >= (questions.length / 2);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: _isDarkMode ? Colors.black87 : Colors.white, // Fondo más oscuro o más claro
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0), // Bordes redondeados
        ),
        title: Row(
          children: [
            Icon(
              isVictory ? Icons.check_circle_outline : Icons.cancel_outlined, // Icono de victoria o derrota
              color: isVictory ? Colors.green : Colors.red, // Verde para victoria, rojo para derrota
              size: 30,
            ),
            SizedBox(width: 10),
            Text(
              isVictory ? '¡Victoria!' : '¡Derrota!',
              style: TextStyle(
                color: _isDarkMode ? Colors.white : Colors.black, // Texto en blanco o negro
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Text(
          'Puntuación: $_score de ${questions.length}', // Mostrar la puntuación
          style: TextStyle(
            color: _isDarkMode ? Colors.white70 : Colors.black87,
            fontSize: 18,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _currentQuestionIndex = 0;
                _answered = false;
                _score = 0;
                _selectedAnswer = null;
                _questions = _loadRandomQuestions(); // Recarga las preguntas aleatorias
              });
            },
            child: Text('Reiniciar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
  '/menu',
  (Route<dynamic> route) => false, // Elimina todas las rutas anteriores
);
            },
            child: Text('Salir'),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildThemeToggle() {
    return [
      Icon(_isDarkMode ? Icons.nights_stay : Icons.wb_sunny, color: _isDarkMode ? Colors.white : Colors.black),
      SizedBox(width: 10),
      Switch(
        value: _isDarkMode,
        onChanged: (bool value) {
          setState(() {
            _isDarkMode = value;
            widget.onThemeChanged?.call(value);
          });
        },
      ),
    ];
  }
}
