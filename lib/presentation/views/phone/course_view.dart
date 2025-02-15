import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learnt_app/helper/class/register_extra.dart';
import 'package:learnt_app/helper/class/section_extra.dart';
import 'package:learnt_app/helper/routes/app_routes.dart';
import 'package:learnt_app/helper/style/app_style.dart';
import 'package:learnt_app/presentation/widgets/arrow_back_widget.dart';
import 'package:learnt_app/presentation/widgets/course_card_widget.dart';
import 'package:learnt_app/presentation/widgets/course_info_dialog.dart';

import '../../../logic/learnt_cubit.dart';

class CourseView extends StatelessWidget {
  const CourseView({
    super.key,
    this.sectionExtra,
  });
  final SectionExtra? sectionExtra;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LearntCubit>();
    cubit.fetchAllCourses(section: sectionExtra!.section);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: const ArrowBackwidget(
            backViewName: AppRoutes.home,
            iconSize: 24,
          ),
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Column(
            children: [
              // sectionExtra!.isHasExam == true
              //     ? SectionCardWidget(
              //         title: 'حدد مستواك',
              //         imageurl:
              //             'https://jkpqnpbtfghgxthpdxai.supabase.co/storage/v1/object/public/images//logo_you_learnt.png',
              //         widthContainer: double.infinity,
              //         widthImage: double.infinity,
              //         fontSize: 20,
              //         onTap: () {
              //           context.goNamed(AppRoutes.examSart,
              //               extra: sectionExtra!.section);
              //         },
              //       )
              //     : SizedBox(),
              SizedBox(height: 30.h),
              Row(
                children: [
                  Text(
                    'الدورات',
                    style: AppStyle.titleStyle,
                  ),
                  SizedBox(width: 10.w),
                  Image.asset(
                    'assets/images/video-call-webcam-svgrepo-com.png',
                    height: 60.h,
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              BlocBuilder<LearntCubit, LearntState>(
                builder: (context, state) {
                  if (state is LearntLoadSectionFailure) {
                    return Text(state.message);
                  }
                  if (state is LearntLoadCourseSuccess) {
                    return Expanded(
                      child: ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.courses.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            child: CoursesCardWidget(
                              isSmallScreen: false,
                              isPhone: true,
                              courseName: state.courses[index].name,
                              imageUrl: state.courses[index].image,
                              price: state.courses[index].price,
                              hours: state.courses[index].hours,
                              description: state.courses[index].description,
                              color: Colors.white,
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return CourseInfoDialog(
                                      extra: RegisterExtra(
                                        subject: state.courses[index].name,
                                        section:
                                            state.courses[index].sectionName,
                                      ),
                                      course: state.courses[index],
                                    );
                                  },
                                );
                              },
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
