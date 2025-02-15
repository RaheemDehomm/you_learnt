import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learnt_app/data/model/question.dart';
import 'package:learnt_app/helper/style/app_style.dart';
import 'package:learnt_app/logic/question_cubit.dart';
import 'package:learnt_app/presentation/widgets/answer_user_widget.dart';

class QuestionsWidget extends StatelessWidget {
  const QuestionsWidget({super.key, required this.questions});
  final List<Question> questions;

  @override
  Widget build(BuildContext context) {
    var cubit = context.watch<QuestionCubit>();

    return BlocBuilder<QuestionCubit, QuestionState>(
      builder: (context, state) {
        return Center(
          child: questions.length > 0
              ? Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        questions[cubit.index].questionText,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.ltr,
                        style: AppStyle.descriptionStyle.copyWith(
                          fontSize: MediaQuery.of(context).size.width > 600
                              ? MediaQuery.of(context).size.width * 0.02
                              : MediaQuery.of(context).size.width * 0.02,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      ...questions[cubit.index].options.map(
                        (option) {
                          return SingleChildScrollView(
                            child: Column(
                              children: [
                                AnswerWidget(
                                  answer: option,
                                  onTap: () {
                                    cubit.setUserAnswer(option);
                                    cubit.nextQuestion();
                                  },
                                ),
                                SizedBox(height: 5.h),
                              ],
                            ),
                          );
                        },
                      ).toList(),
                    ],
                  ),
                )
              : Text(
                  'حدث خطأ يرجى المحاولة مرة أخرى',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.ltr,
                  style: AppStyle.descriptionStyle.copyWith(
                    fontSize: MediaQuery.of(context).size.width > 600
                        ? MediaQuery.of(context).size.width * 0.02
                        : MediaQuery.of(context).size.width * 0.01,
                  ),
                ),
        );
      },
    );
  }
}
