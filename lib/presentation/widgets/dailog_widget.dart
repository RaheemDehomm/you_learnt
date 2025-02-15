import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learnt_app/helper/style/app_style.dart';

class DailogWidget extends StatefulWidget {
  const DailogWidget({super.key, this.title, this.isSuccess});
  final String? title;
  final bool? isSuccess;

  @override
  State<DailogWidget> createState() => _DailogWidgetState();
}

class _DailogWidgetState extends State<DailogWidget> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.of(context).pop(); // Close dialog
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(16.r),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              widget.isSuccess == false
                  ? 'assets/images/error-svgrepo-com (1).png'
                  : 'assets/images/success-svgrepo-com (1).png',
              height: MediaQuery.of(context).size.width * 0.1,
            ),
            Text(
              widget.title ??
                  (widget.isSuccess == false
                      ? 'حدث خطأ ما'
                      : 'تمت العملية بنجاح'),
              style: AppStyle.titleStyle.copyWith(
                  color: Colors.black,
                  fontSize: MediaQuery.of(context).size.width * 0.06),
            ),
          ],
        ),
      ),
    );
  }
}
