import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learnt_app/helper/style/app_style.dart';
import 'package:learnt_app/helper/style/const_style.dart';

class SectionCardWidget extends StatelessWidget {
  const SectionCardWidget({
    super.key,
    this.imageurl,
    this.title,
    this.onTap,
    this.hieghtImage,
    this.color,
    this.titleColor,
    this.fontSize,
    this.hieghtContainer,
    this.widthContainer,
    this.widthImage,
  });
  final String? imageurl;
  final String? title;
  final void Function()? onTap;
  final double? hieghtImage;
  final Color? color;
  final Color? titleColor;
  final double? fontSize;
  final double? hieghtContainer;
  final double? widthContainer;
  final double? widthImage;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        width: widthContainer ?? MediaQuery.of(context).size.width * 0.3,
        height: hieghtContainer ?? MediaQuery.of(context).size.height * 0.25,
        margin: EdgeInsets.symmetric(horizontal: 5.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: color ?? kPrimaryColor,
          border: Border.all(
            color: const Color.fromARGB(255, 220, 212, 212),
            width: 1.w,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: Image.network(
                imageurl ?? 'assets/images/england-svgrepo-com.png',
                height: hieghtImage?.h ?? 100.h,
                width: widthImage ?? double.infinity,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              title ?? 'لغة إنجليزية',
              textAlign: TextAlign.center,
              style: AppStyle.titleStyle.copyWith(
                  color: titleColor ?? Colors.white,
                  fontSize: fontSize?.sp ?? 18.sp),
            ),
          ],
        ),
      ),
    );
  }
}
