import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  final Function(bool)? onThemeChanged; // Callback para cambiar el tema
  final bool isDarkMode;

  const QuizPage({this.onThemeChanged, this.isDarkMode = false, Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  late bool _isDarkMode;

  @override
  void initState() {
    super.initState();
    _isDarkMode = widget.isDarkMode;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // Reutilizamos la lógica de MenuPage
    final bool hideFooter = screenHeight < 480 || screenWidth < 300;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
        backgroundColor: Colors.red,
        actions: [
          Row(
            mainAxisSize: MainAxisSize.min,  // Asegura que los elementos ocupen solo el espacio necesario
            children: [
              
            ],
          ),
        ],
      ),
      body: Center(
        child: Text(
          'Aquí irá el contenido del Quiz',
          style: TextStyle(fontSize: 20),
        ),
      ),
      bottomNavigationBar: hideFooter
          ? null
          : Container(
              padding: const EdgeInsets.all(16.0),
              child: Builder(
                builder: (context) {
                  final screenWidth = MediaQuery.of(context).size.width;
                  final isTooNarrow = screenWidth < 126;

                  return isTooNarrow
                      ? SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(children: _buildThemeToggle()),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: _buildThemeToggle(),
                        );
                },
              ),
            ),
      floatingActionButton: hideFooter
          ? Container(
              padding: const EdgeInsets.only(left: 12, top: 12),
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

  List<Widget> _buildThemeToggle() {
    return [
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
            widget.onThemeChanged?.call(value);
          });
        },
      ),
    ];
  }
}
