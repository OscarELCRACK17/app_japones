class Question {
  final int id; // Mantén la ID en el modelo
  final String question;
  final List<String> options;
  final String correctAnswer;

  Question({
    required this.id,
    required this.question,
    required this.options,
    required this.correctAnswer,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'], // Lee la ID del JSON
      question: json['question'],
      options: List<String>.from(json['options']),
      correctAnswer: json['answer'],
    );
  }
}
