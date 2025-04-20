// lib/features/menu/widgets/menu_header.dart
import 'package:flutter/material.dart';

class MenuHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset('assets/images/flag_japan.png'),
        SizedBox(height: 30),
        Text(
          'Vocabulario Japonés',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
