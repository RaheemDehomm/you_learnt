import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learnt_app/helper/class/register_extra.dart';
import 'package:learnt_app/helper/style/app_style.dart';
import 'package:learnt_app/presentation/widgets/course_card_widget.dart';
import 'package:learnt_app/presentation/widgets/course_info_web_dialog.dart';

import '../../../logic/learnt_cubit.dart';

class CourseWebView extends StatelessWidget {
  const CourseWebView({
    super.key,
    this.section,
  });
  final String? section;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LearntCubit>();

    cubit.fetchAllCourses(
        section:
            section == null || section == '' ? cubit.sectionName : section);

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.04,
            vertical: screenHeight * 0.02,
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'الدورات',
                          style: AppStyle.titleStyle.copyWith(
                            fontSize: screenWidth * 0.06, // dynamic font size
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.02),
                        Image.asset(
                          'assets/images/video-call-webcam-svgrepo-com.png',
                          height: screenHeight * 0.1, // dynamic image size
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    BlocBuilder<LearntCubit, LearntState>(
                      builder: (context, state) {
                        if (state is LearntLoadSectionFailure) {
                          return Text(state.message);
                        }
                        if (state is LearntLoadCourseSuccess) {
                          return GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: screenWidth > 600
                                  ? MediaQuery.of(context).size.width / 4
                                  : MediaQuery.of(context).size.width / 2,
                              crossAxisSpacing:
                                  MediaQuery.of(context).size.width *
                                      0.01, // المسافة الأفقية بين العناصر
                              mainAxisSpacing:
                                  MediaQuery.of(context).size.height *
                                      0.02, // المسافة العمودية بين العناصر
                              childAspectRatio:
                                  MediaQuery.of(context).size.width < 600
                                      ? 0.8
                                      : 1.5,
                            ),
                            itemCount: state.courses.length,
                            itemBuilder: (context, index) {
                              double screenWidth =
                                  MediaQuery.of(context).size.width;
                              double screenHeight =
                                  MediaQuery.of(context).size.height;

                              double fontSize = screenWidth < 600
                                  ? screenHeight * 0.015
                                  : screenHeight * 0.03;
                              double fontSizeDescription = screenWidth < 600
                                  ? screenHeight * 0.013
                                  : screenHeight * 0.02;
                              double imageHeight = screenWidth < 600
                                  ? screenHeight * 0.06
                                  : screenHeight * 0.08;
                              double iconSize = screenWidth < 600
                                  ? screenHeight * 0.02
                                  : screenHeight * 0.03;
                              double titleFontSize = screenWidth < 600
                                  ? screenHeight * 0.015
                                  : screenHeight * 0.02;

                              return CoursesCardWidget(
                                isPhone: false,
                                courseName: state.courses[index].name,
                                imageUrl: state.courses[index].image,
                                price: state.courses[index].price,
                                hours: state.courses[index].hours,
                                description: state.courses[index].description,
                                color: Colors.white,
                                onTap: () {
                                  cubit.setSRegister(state.courses[index].name,
                                      state.courses[index].sectionName);

                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return CourseInfoWebDialog(
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
                                fontSize: fontSize,
                                fontSizedescription: fontSizeDescription,
                                titleColor: Colors.white,
                                hieghtImage: imageHeight,
                                iconSize: iconSize,
                                titleFontSize: titleFontSize,
                                isSmallScreen:
                                    screenWidth < 600 || screenWidth <= 1110,
                              );
                            },
                          );
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
