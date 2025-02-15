import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:learnt_app/helper/routes/app_routes.dart';

class ArrowBackwidget extends StatelessWidget {
  const ArrowBackwidget({
    super.key,
    this.backViewName,
    this.iconSize,
    this.color,
    this.onTap,
  });
  final String? backViewName;
  final double? iconSize;
  final Color? color;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: onTap ??
              () {
                context.goNamed(backViewName ?? AppRoutes.home);
                // Navigator.of(context).pop();
              },
          icon: Icon(
            Icons.arrow_back,
            color: color ?? Colors.black,
          ),
          iconSize: iconSize?.h ?? 24.h,
        ),
      ],
    );
  }
}
