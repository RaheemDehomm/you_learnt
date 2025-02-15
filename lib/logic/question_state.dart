part of 'question_cubit.dart';

@immutable
abstract class QuestionState {}

class QuestionInitial extends QuestionState {}

class QuestionLoading extends QuestionState {}

class QuestionSuccess extends QuestionState {
  final List<Question> questions;
  QuestionSuccess(this.questions);
}

class QuestionSuccessWithLevel extends QuestionState {
  final String level;
  QuestionSuccessWithLevel(this.level);
}

class QuestionFailure extends QuestionState {
  final String message;
  QuestionFailure(this.message);
}

class QuestionDisplayed extends QuestionState {
  final int index;
  QuestionDisplayed(this.index);
}

class QuestionAnswered extends QuestionState {
  final String answer;
  QuestionAnswered(this.answer);
}

class QuestionFinished extends QuestionState {
  final String level;
  QuestionFinished(this.level);
} // حالة انتهاء الأسئلة