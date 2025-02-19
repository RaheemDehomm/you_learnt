import 'package:flutter/material.dart';
import 'package:learnt_app/helper/style/app_style.dart';

class AnswerWidget extends StatelessWidget {
  const AnswerWidget({
    super.key,
    this.answer,
    this.onTap,
  });
  final String? answer;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap ?? () {},
      child: Text(
        answer ?? 'الإجابة',
        style: AppStyle.descriptionStyle.copyWith(
          color: Colors.black,
          fontSize: MediaQuery.of(context).size.width > 600
              ? MediaQuery.of(context).size.width * 0.03
              : MediaQuery.of(context).size.width * 0.04,
        ),
      ),
    );
  }
}
