import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:app_japones/data/models/question_model.dart';

class QuestionRepository {
  Future<List<Question>> loadQuestions() async {
    final String response = await rootBundle.loadString('assets/data/questions.json');
    final List<dynamic> data = json.decode(response);
    return data.map((json) => Question.fromJson(json)).toList();
  }
}
