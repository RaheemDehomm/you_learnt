import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learnt_app/helper/routes/app_routes.dart';
import 'package:learnt_app/presentation/widgets/section_card_widget.dart';

class CourseInfoWidget extends StatelessWidget {
  const CourseInfoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SectionCardWidget(
              title: 'سجل الأن',
              imageurl: 'assets/images/student.png',
              onTap: () {
                context.goNamed(AppRoutes.register);
              },
            ),
            SectionCardWidget(
              title: 'حدد مستواك',
              imageurl: 'assets/images/test-exam-svgrepo-com.png',
              // hieghtImage: 80.h,
              onTap: () {
                context.goNamed(AppRoutes.examSart);
              },
            ),
          ],
        ),
      ],
    );
  }
}
