part of 'learnt_cubit.dart';

@immutable
abstract class LearntState {}

class LearntInitial extends LearntState {
  final String? section;
  final String? subject;

  LearntInitial({this.section, this.subject});
}

class LearntLoadSectionSuccess extends LearntState {
  final List<Section> sections;
  LearntLoadSectionSuccess(this.sections);
}

class LearntLoadCourseSuccess extends LearntState {
  final List<Course> courses;
  LearntLoadCourseSuccess(this.courses);
}

class LearntLoadCourseFailure extends LearntState {
  final String message;
  LearntLoadCourseFailure(this.message);
}

class LearntLoadSectionFailure extends LearntState {
  final String message;
  LearntLoadSectionFailure(this.message);
}

class LearntLoadDataRegistration extends LearntState {
  final String section;
  final String subject;
  LearntLoadDataRegistration(this.section, this.subject);
}

class LearntLoading extends LearntState {}
