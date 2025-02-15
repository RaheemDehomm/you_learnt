class Question {
  final String questionText; // نص السؤال
  final List<String> options; // قائمة الاختيارات
  final String correctAnswer; // الإجابة الصحيحة
  final String level; // مستوى السؤال (مثل Basic، Beginner، إلخ)

  Question({
    required this.questionText,
    required this.options,
    required this.correctAnswer,
    required this.level,
  });

  @override
  String toString() {
    return 'مستوى: $level\nالسؤال: $questionText\nالاختيارات: $options\nالإجابة الصحيحة: $correctAnswer\n';
  }
}
