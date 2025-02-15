import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:learnt_app/helper/routes/app_routes.dart';
import 'package:learnt_app/helper/style/app_style.dart';
import 'package:learnt_app/helper/style/const_style.dart';
import 'package:learnt_app/presentation/widgets/arrow_back_widget.dart';

class BodyStartExamWidget extends StatelessWidget {
  const BodyStartExamWidget({super.key, this.section});
  final String? section;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MediaQuery.of(context).size.width < 600
          ? AppBar(
              leading: const ArrowBackwidget(
                backViewName: AppRoutes.course,
                iconSize: 24,
                color: Colors.white,
              ),
              backgroundColor: kPrimaryColor,
            )
          : AppBar(
              backgroundColor: kPrimaryColor,
            ),
      backgroundColor: kPrimaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/exam.png',
              height: 170.h,
            ),
            OutlinedButton.icon(
              onPressed: () {
                context.goNamed(AppRoutes.exam, extra: section ?? '');
              },
              style: OutlinedButton.styleFrom(
                shape: const StadiumBorder(),
                side: const BorderSide(color: Colors.white),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
              ),
              label: Text(
                'إبدأ',
                style: AppStyle.titleStyle.copyWith(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.width < 600
                        ? 30.sp
                        : MediaQuery.of(context).size.width * 0.05),
              ),
              icon: Icon(
                Icons.arrow_right_alt,
                color: Colors.white,
                size: 32.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
