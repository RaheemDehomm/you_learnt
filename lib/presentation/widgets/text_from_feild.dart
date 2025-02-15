import 'package:flutter/material.dart';
import 'package:learnt_app/helper/constant.dart';
import 'package:learnt_app/helper/style/app_style.dart';

import '../../helper/style/const_style.dart';

class TextBoxForm extends StatelessWidget {
  const TextBoxForm({
    super.key,
    required this.controller,
    this.labelText,
    this.keyboardType,
    this.suffixIcon,
    this.prefixIcon,
    this.readOnly,
    this.inputType = InputType.text,
    this.errorText,
    this.fontTitleSize,
  });

  final TextEditingController controller;
  final String? labelText;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? readOnly;
  final InputType inputType;
  final String? errorText;
  final double? fontTitleSize;

  String? _validateInput(String? value) {
    if (value == null || value.trim().isEmpty) {
      return errorText ?? 'هذا الحقل لا يمكن أن يكون فارغًا';
    }

    if (inputType == InputType.email) {
      bool isValidEmail =
          RegExp(r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$")
              .hasMatch(value);
      if (!isValidEmail) return 'البريد الإلكتروني غير صالح';
    }

    if (inputType == InputType.phone) {
      bool isValidPhone = RegExp(r'^\+?\d{10,15}$').hasMatch(value);
      if (!isValidPhone) return 'رقم الهاتف غير صالح';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType ??
          (inputType == InputType.phone
              ? TextInputType.phone
              : inputType == InputType.email
                  ? TextInputType.emailAddress
                  : TextInputType.text),
      controller: controller,
      readOnly: readOnly ?? false,
      decoration: InputDecoration(
        suffixIcon: suffixIcon ?? const SizedBox(),
        prefixIcon: prefixIcon ?? const SizedBox(),
        labelText: labelText ?? 'الاسم الكامل',
        labelStyle: AppStyle.descriptionStyle.copyWith(
            color: Colors.grey,
            fontSize:
                fontTitleSize ?? MediaQuery.of(context).size.width * 0.06),
        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(MediaQuery.of(context).size.width * 0.03),
          borderSide: const BorderSide(
            color: kPrimaryColor,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(MediaQuery.of(context).size.width * 0.03),
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 1,
          ),
          gapPadding: 0,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(MediaQuery.of(context).size.width * 0.03),
          borderSide: const BorderSide(
            color: Colors.green,
            width: 1,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(MediaQuery.of(context).size.width * 0.03),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1,
          ),
          gapPadding: MediaQuery.of(context).size.width * 0.02,
        ),
      ),
      validator: _validateInput,
    );
  }
}
