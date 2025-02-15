import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learnt_app/helper/class/section_extra.dart';
import 'package:learnt_app/helper/style/const_style.dart';
import 'package:learnt_app/logic/question_cubit.dart';
import 'package:learnt_app/presentation/widgets/body_start_exam_widget.dart';

class ExamSartView extends StatelessWidget {
  const ExamSartView({super.key, this.sectionExtra});
  final SectionExtra? sectionExtra;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<QuestionCubit, QuestionState>(
        builder: (context, state) {
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 70, 104, 176),
                  kPrimaryColor,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: BodyStartExamWidget(
              section: sectionExtra?.section ?? '',
            ),
          );
        },
      ),
    );
  }
}
