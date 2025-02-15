import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learnt_app/helper/style/app_style.dart';

class CoursesCardWidget extends StatelessWidget {
  const CoursesCardWidget({
    super.key,
    this.courseName,
    this.imageUrl,
    this.price,
    this.hours,
    this.description,
    this.color,
    this.onTap,
    this.isSection,
    this.fontSize,
    this.fontSizedescription,
    this.hieghtImage,
    this.titleColor,
    this.iconSize,
    this.titleFontSize,
    this.isSmallScreen,
    this.isPhone,
  });

  final String? courseName;
  final String? imageUrl;
  final String? price;
  final String? hours;
  final String? description;
  final Color? color;
  final void Function()? onTap;
  final bool? isSection;
  final double? fontSize;
  final double? fontSizedescription;
  final double? hieghtImage;
  final Color? titleColor;
  final double? iconSize;
  final double? titleFontSize;
  final bool? isSmallScreen;
  final bool? isPhone;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        width: MediaQuery.of(context).size.width * 0.3,
        height: isPhone == true
            ? MediaQuery.of(context).size.height * 0.4
            : MediaQuery.of(context).size.height * 0.3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: const Color(0xFF2c4885),
          border: Border.all(
            color: const Color.fromARGB(255, 220, 212, 212),
            width: 1.w,
          ),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
              ),
              child: Image.network(
                imageUrl ?? 'assets/images/splashImage.png',
                height: hieghtImage ?? MediaQuery.of(context).size.height * 0.2,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${courseName ?? 'beginner'}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: AppStyle.descriptionStyle
                            .copyWith(fontSize: fontSize ?? 22.sp),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.arrow_forward_sharp,
                        color: Colors.white,
                        size: iconSize ?? 28.w,
                      ),
                      onPressed: onTap ?? () {},
                    ),
                  ],
                )),
            SizedBox(height: 3.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      description ??
                          'دورة التعلم المفتوحة والمجانية للمتعلمين في العالم الأول والثاني والثالث والرابع والخامس والسادس والسابع والثامن والتاسع والعاشر والحادي والاثنين والثلاثاء والأربعاء والخميس والجمعة والسنة',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: AppStyle.descriptionStyle.copyWith(
                        color: Colors.grey[270],
                        fontSize: fontSizedescription ?? 16.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Divider(
                  thickness: 1.h,
                  height: 2.h,
                  color: Colors.white,
                ),
                Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
                    child: isSmallScreen == false
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'عدد الساعات: ${hours ?? '25'}',
                                style: AppStyle.descriptionStyle
                                    .copyWith(fontSize: titleFontSize ?? 16.sp),
                              ),
                              Text(
                                'السعر: ${price ?? '200'}',
                                style: AppStyle.descriptionStyle
                                    .copyWith(fontSize: titleFontSize ?? 16.sp),
                              ),
                            ],
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'عدد الساعات: ${hours ?? '25'}',
                                style: AppStyle.descriptionStyle
                                    .copyWith(fontSize: titleFontSize ?? 16.sp),
                              ),
                              Text(
                                'السعر: ${price ?? '200'}',
                                style: AppStyle.descriptionStyle
                                    .copyWith(fontSize: titleFontSize ?? 16.sp),
                              ),
                            ],
                          )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
