import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learnt_app/helper/style/const_style.dart';

class Infowidget extends StatelessWidget {
  const Infowidget({
    super.key,
    this.imageUrl,
    this.title,
    this.imageDescription,
    this.onTap,
  });
  final String? imageUrl;
  final String? title;
  final String? imageDescription;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    color: kPrimaryColor,
                    border: Border.all(
                      color: const Color.fromARGB(255, 220, 212, 212),
                      width: 1.w,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10.0,
                        spreadRadius: 5.0,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16.r),
                            topRight: Radius.circular(16.r)),
                        child: Image.asset(
                          imageUrl ?? 'assets/images/splashImage.png',
                          height: 100.h,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            title ?? 'منصتنا خيارك الأول',
                            style: TextStyle(
                              fontSize: 24.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: kFontFamily,
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Image.asset(
                            imageDescription ??
                                'assets/images/teacher-male-svgrepo-com.png',
                            height: 50.h,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
