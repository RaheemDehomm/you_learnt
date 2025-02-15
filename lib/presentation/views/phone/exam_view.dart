import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:learnt_app/helper/routes/app_routes.dart';
import 'package:learnt_app/helper/style/app_style.dart';
import 'package:learnt_app/helper/style/const_style.dart';
import 'package:learnt_app/logic/question_cubit.dart';
import 'package:learnt_app/presentation/widgets/question_widget.dart';

class ExamView extends StatelessWidget {
  const ExamView({super.key, this.section});
  final String? section;
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<QuestionCubit>();
    cubit.getAllQuestions('english');
    return Scaffold(
      body: Container(
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
        child: BlocBuilder<QuestionCubit, QuestionState>(
          builder: (context, state) {
            if (state is QuestionLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            }
            if (state is QuestionSuccess) {
              return QuestionsWidget(
                questions: state.questions,
              );
            }
            if (state is QuestionFailure) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.white),
                ),
              );
            }
            if (state is QuestionFinished) {
              cubit.evaluateUserLevel();

              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'نتيجة الإمتحان',
                      style: AppStyle.titleStyle.copyWith(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width > 600
                            ? MediaQuery.of(context).size.width * 0.06
                            : MediaQuery.of(context).size.width * 0.05,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      state.level,
                      style: AppStyle.titleStyle.copyWith(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width > 600
                              ? MediaQuery.of(context).size.width * 0.06
                              : MediaQuery.of(context).size.width * 0.05),
                    ),
                    SizedBox(height: 20.h),
                    Divider(
                      thickness: 1.h,
                      height: 2.h,
                      color: Colors.white,
                    ),
                    SizedBox(height: 20.h),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        side: const BorderSide(color: Colors.white),
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 20.w),
                      ),
                      onPressed: () {
                        context.goNamed(
                          section == null || section == ''
                              ? AppRoutes.homeWeb
                              : AppRoutes.home,
                        );
                      },
                      child: Text(
                        "تصفح الدورات",
                        textAlign: TextAlign.center,
                        style: AppStyle.titleStyle.copyWith(
                            color: Colors.black,
                            fontSize: MediaQuery.of(context).size.width > 600
                                ? MediaQuery.of(context).size.width * 0.06
                                : MediaQuery.of(context).size.width * 0.05),
                      ),
                    ),
                  ],
                ),
              );
            }
            if (state is QuestionDisplayed || state is QuestionAnswered) {
              return QuestionsWidget(
                questions: cubit.questions,
              );
            }
            // الحالة الافتراضية
            return const Center(
              child: Text(
                "",
                style: TextStyle(color: Colors.black, fontSize: 24),
              ),
            );
          },
        ),
      ),
    );
  }
}
