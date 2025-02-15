import 'dart:convert';
import 'dart:developer';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:learnt_app/data/model/question.dart';

class ExamService {
  final GenerativeModel model;

  ExamService()
      : model = GenerativeModel(
          model: 'gemini-1.5-flash',
          apiKey: 'AIzaSyCendmDpQ6SpkWHrBJNsBeaKvZSWGleXfs',
        );

  Future<List<Question>> generateExamQuestions(String language) async {
    try {
      final userPrompt = """
        قم بإنشاء 7 أسئلة اختيار من متعدد لاختبار تحديد المستوى في لغة $language، بناءً على منهج English Hubs.
        يجب أن تكون الأسئلة موزعة على المستويات التالية:
        - Basic (1 سؤال)
        - Beginner (1 سؤال)
        - Elementary (1 سؤال)
        - Pre-Intermediate (1 سؤال)
        - Intermediate (1 سؤال)
        - Advanced (1 سؤال)

        لكل سؤال، أضف 4 اختيارات، واحد فقط منها صحيح.
        أرسل النتائج في تنسيق JSON صالح كالتالي:
        {
          "questions": [
            {
              "level": "Basic", // مستوى السؤال
              "question": "What is the correct sentence?",
              "options": ["He go to school", "He goes to school", "He going to school", "He went school"],
              "correct_answer": "He goes to school"
            }
          ]
        }
      """;

      final response = await model.generateContent([Content.text(userPrompt)]);

      final responseText = response.text;
      if (responseText == null) {
        throw Exception("No response text received");
      }

      log("Raw Response: $responseText");

      final cleanedResponseText =
          responseText.replaceAll("```json", "").replaceAll("```", "").trim();

      final List<Question> questions =
          parseQuestionsFromResponse(cleanedResponseText);
      return questions;
    } catch (e) {
      log("❌ حدث خطأ: $e");
      return [];
    }
  }

  List<Question> parseQuestionsFromResponse(String responseText) {
    try {
      final Map<String, dynamic> jsonData = jsonDecode(responseText);
      final List<dynamic> questionsJson = jsonData['questions'];

      return questionsJson.map((questionJson) {
        return Question(
          questionText: questionJson['question'],
          options: List<String>.from(questionJson['options']),
          correctAnswer: questionJson['correct_answer'],
          level: questionJson['level'],
        );
      }).toList();
    } catch (e) {
      log("❌ فشل تحليل JSON: $e");
      return [];
    }
  }

  Future<String> evaluateUserLevel(
      List<Question> questions, List<String> userAnswers) async {
    Map<String, int> correctAnswersByLevel = {
      "Basic": 0,
      "Beginner": 0,
      "Elementary": 0,
      "Pre-Intermediate": 0,
      "Intermediate": 0,
      "Advanced": 0,
    };

    for (int i = 0; i < questions.length; i++) {
      if (i < userAnswers.length &&
          questions[i].correctAnswer == userAnswers[i]) {
        correctAnswersByLevel[questions[i].level] =
            correctAnswersByLevel[questions[i].level]! + 1;
      }
    }

    String highestLevel = correctAnswersByLevel.keys.first;
    int highestCount = correctAnswersByLevel[highestLevel]!;

    correctAnswersByLevel.forEach((level, count) {
      if (count > highestCount) {
        highestLevel = level;
        highestCount = count;
      }
    });

    return highestLevel;
  }
}
