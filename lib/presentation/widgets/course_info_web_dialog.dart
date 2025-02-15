import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learnt_app/data/model/course.dart';
import 'package:learnt_app/helper/class/register_extra.dart';
import 'package:learnt_app/helper/routes/app_routes.dart';
import 'package:learnt_app/helper/style/const_style.dart';

class CourseInfoWebDialog extends StatelessWidget {
  const CourseInfoWebDialog({super.key, this.extra, required this.course});
  final RegisterExtra? extra;
  final Course course;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = constraints.maxWidth;
          double screenHeight = constraints.maxHeight;

          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05, vertical: screenHeight * 0.05),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Info Image
                  Image.asset(
                    'assets/images/info.png',
                    height: screenHeight * 0.1,
                    width: screenWidth * 0.25,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: screenHeight * 0.02),

                  // Course Title
                  Text(
                    'بيانات الدورة',
                    style: TextStyle(
                      fontSize: screenWidth * 0.06,
                      fontWeight: FontWeight.bold,
                      fontFamily: kFontFamily,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),

                  // Course Level
                  Text(
                    'الدورة: ${course.name}',
                    style: TextStyle(
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.bold,
                      fontFamily: kFontFamily,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),

                  // Course Description
                  Text(
                    'الوصف: ${course.description}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.bold,
                      fontFamily: kFontFamily,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),

                  // Course Details (Hours & Price)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'عدد الساعات: ${course.hours}',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.bold,
                          fontFamily: kFontFamily,
                        ),
                      ),
                      Text(
                        'السعر: ${course.price}',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.bold,
                          fontFamily: kFontFamily,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.02),

                  // Action Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Register Button
                      ElevatedButton(
                        onPressed: () {
                          context.goNamed(AppRoutes.register, extra: extra);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 0,
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.03,
                            vertical: screenWidth * 0.015,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'سجل الأن',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: screenWidth * 0.05,
                                fontWeight: FontWeight.bold,
                                fontFamily: kFontFamily,
                              ),
                            ),
                            SizedBox(width: screenWidth * 0.02),
                            Image.asset(
                              'assets/images/student.png',
                              height: screenHeight * 0.05,
                            ),
                          ],
                        ),
                      ),

                      // Close Button
                      ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 0,
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.03,
                            vertical: screenWidth * 0.015,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'إغلاق',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: screenWidth * 0.05,
                                fontWeight: FontWeight.bold,
                                fontFamily: kFontFamily,
                              ),
                            ),
                            SizedBox(width: screenWidth * 0.02),
                            Image.asset(
                              'assets/images/error-svgrepo-com (1).png',
                              height: screenHeight * 0.05,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
