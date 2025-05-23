import 'package:flutter/material.dart';

class ModePage extends StatefulWidget {
  final Function(bool)? onThemeChanged;
  final bool isDarkMode;

  const ModePage({this.onThemeChanged, this.isDarkMode = false, Key? key}) : super(key: key);

  @override
  State<ModePage> createState() => _ModePageState();
}

class _ModePageState extends State<ModePage> {
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

    final bool hideFooter = screenHeight < 480 || screenWidth < 300;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('日本語学ぶ',
        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Text(
          'Selecciona tu modo',
          style: TextStyle(fontSize: 20),
        ),
      ),
      bottomNavigationBar: hideFooter
          ? null
          : Container(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: _buildThemeToggle(),
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
