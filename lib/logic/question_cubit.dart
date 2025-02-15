import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:learnt_app/data/model/question.dart';
import 'package:learnt_app/helper/api.dart';
import 'package:meta/meta.dart';

part 'question_state.dart';

class QuestionCubit extends Cubit<QuestionState> {
  QuestionCubit() : super(QuestionInitial());

  int index = 0; // الفهرس الحالي للسؤال
  List<Question> questions = []; // قائمة الأسئلة
  List<String> userAnswers = []; // قائمة إجابات المستخدم

  // الانتقال إلى السؤال التالي
  void nextQuestion() {
    if (index < questions.length - 1) {
      index++;
      emit(QuestionDisplayed(index)); // إصدار حالة جديدة مع الفهرس المحدث
    } else {
      emit(QuestionFinished('')); // إصدار حالة تشير إلى انتهاء الأسئلة
    }
  }

  // تعيين إجابة المستخدم
  void setUserAnswer(String answer) {
    if (index < userAnswers.length) {
      userAnswers[index] = answer; // تحديث الإجابة إذا كانت موجودة
    } else {
      userAnswers.add(answer); // إضافة إجابة جديدة
    }
    emit(QuestionAnswered(answer)); // إصدار حالة تشير إلى اختيار إجابة
  }

  // جلب جميع الأسئلة
  Future<void> getAllQuestions(String language) async {
    emit(QuestionLoading());
    try {
      questions = await ExamService().generateExamQuestions(language);

      emit(QuestionSuccess(questions));
    } catch (e) {
      log(e.toString());
      emit(QuestionFailure(e.toString()));
    }
  }

  // تقييم مستوى المستخدم
  Future<void> evaluateUserLevel() async {
    emit(QuestionLoading());
    try {
      final String userLevel =
          await ExamService().evaluateUserLevel(questions, userAnswers);
      emit(QuestionFinished(userLevel));
    } catch (e) {
      emit(QuestionFailure(e.toString()));
    }
  }
}
