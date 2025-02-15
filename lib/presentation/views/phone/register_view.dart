import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:learnt_app/helper/constant.dart';
import 'package:learnt_app/helper/routes/app_routes.dart';
import 'package:learnt_app/helper/style/app_style.dart';
import 'package:learnt_app/helper/style/const_style.dart';
import 'package:learnt_app/logic/learnt_cubit.dart';
import 'package:learnt_app/presentation/widgets/arrow_back_widget.dart';
import 'package:learnt_app/presentation/widgets/dailog_widget.dart';
import 'package:learnt_app/presentation/widgets/text_from_feild.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key, this.subject, this.section});
  final String? subject;
  final String? section;

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late String? subject;
  late String? section;

  @override
  void initState() {
    super.initState();
    subject = widget.subject ?? '';
    section = widget.section ?? '';
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final cubit = context.read<LearntCubit>();

    if ((subject == null || subject == '') &&
        (section == null || section == '')) {
      subject = cubit.subject;
      section = cubit.sectionName;
    }
    if (cubit.subject == '') {
      subject = cubit.getSubject();
    }
    if (cubit.sectionName == '') {
      section = cubit.getSection();
    }

    bool isWeb = kIsWeb;

    return BlocBuilder<LearntCubit, LearntState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            appBar: isWeb == false
                ? AppBar(
                    leading: ArrowBackwidget(
                      onTap: () {
                        context.goNamed(AppRoutes.course, extra: section);
                      },
                      iconSize: 24,
                    ),
                    backgroundColor: Colors.white,
                  )
                : AppBar(
                    backgroundColor: Colors.white,
                  ),
            body: Padding(
              padding: EdgeInsets.all(screenWidth * 0.05),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'إنضم معنا',
                            style: AppStyle.titleStyle.copyWith(
                              fontSize: screenWidth < 600
                                  ? screenHeight * 0.04
                                  : screenHeight * 0.03,
                            ),
                          ),
                          SizedBox(
                            width: screenWidth * 0.02,
                          ),
                          Image.asset(
                            'assets/images/check-mark-button-svgrepo-com.png',
                            height: 40.h,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: screenHeight * 0.04,
                      ),
                      Form(
                        key: cubit.formKey,
                        child: Column(
                          children: [
                            TextBoxForm(
                              controller: cubit.fullNameController,
                              fontTitleSize: screenWidth < 600
                                  ? screenHeight * 0.02
                                  : screenHeight * 0.04,
                              errorText: 'الاسم الكامل لا يمكن أن يكون فارغًا',
                              suffixIcon: Icon(
                                Icons.person,
                                color: kPrimaryColor,
                                size: screenWidth < 600
                                    ? screenHeight * 0.03
                                    : screenHeight * 0.05,
                              ),
                              inputType: InputType.text,
                            ),
                            SizedBox(
                              height: screenHeight * 0.04,
                            ),
                            TextBoxForm(
                              controller: cubit.emailController,
                              fontTitleSize: screenWidth < 600
                                  ? screenHeight * 0.02
                                  : screenHeight * 0.04,
                              labelText: 'البريد الإلكتروني',
                              errorText:
                                  'البريد الإلكتروني لا يمكن أن يكون فارغًا',
                              keyboardType: TextInputType.emailAddress,
                              inputType: InputType.email,
                              suffixIcon: Icon(
                                Icons.email,
                                color: kPrimaryColor,
                                size: screenWidth < 600
                                    ? screenHeight * 0.03
                                    : screenHeight * 0.05,
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 0.04,
                            ),
                            TextBoxForm(
                              controller: cubit.dateController,
                              fontTitleSize: screenWidth < 600
                                  ? screenHeight * 0.02
                                  : screenHeight * 0.04,
                              labelText: 'تاريخ الميلاد',
                              readOnly: true,
                              errorText: 'تاريخ الميلاد لا يمكن أن يكون فارغًا',
                              suffixIcon: IconButton(
                                onPressed: () {
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime(2100),
                                  ).then(
                                    (value) {
                                      if (value != null) {
                                        String formattedDate =
                                            DateFormat('yyyy-MM-dd')
                                                .format(value);
                                        cubit.dateController.text =
                                            formattedDate;
                                      }
                                    },
                                  );
                                },
                                icon: Icon(
                                  Icons.calendar_today,
                                  color: kPrimaryColor,
                                  size: screenWidth < 600
                                      ? screenHeight * 0.03
                                      : screenHeight * 0.05,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 0.04,
                            ),
                            TextBoxForm(
                              controller: cubit.phoneController,
                              fontTitleSize: screenWidth < 600
                                  ? screenHeight * 0.02
                                  : screenHeight * 0.04,
                              labelText: 'رقم الهاتف',
                              errorText: 'رقم الهاتف لا يمكن أن يكون فارغًا',
                              keyboardType: TextInputType.phone,
                              inputType: InputType.phone,
                              suffixIcon: Icon(
                                Icons.phone,
                                color: kPrimaryColor,
                                size: screenWidth < 600
                                    ? screenHeight * 0.03
                                    : screenHeight * 0.05,
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 0.04,
                            ),
                            TextBoxForm(
                              controller: cubit.addressController,
                              fontTitleSize: screenWidth < 600
                                  ? screenHeight * 0.02
                                  : screenHeight * 0.04,
                              labelText: 'مكان السكن',
                              errorText: 'مكان السكن لا يمكن أن يكون فارغًا',
                              keyboardType: TextInputType.text,
                              inputType: InputType.text,
                              suffixIcon: Icon(
                                Icons.location_on,
                                color: kPrimaryColor,
                                size: screenWidth < 600
                                    ? screenHeight * 0.03
                                    : screenHeight * 0.05,
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 0.04,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'مجموعة',
                                  style: AppStyle.descriptionStyle.copyWith(
                                    color: Colors.black,
                                    fontSize: screenWidth < 600
                                        ? screenHeight * 0.02
                                        : screenHeight * 0.04,
                                  ),
                                ),
                                Checkbox(
                                  value: cubit.isGroupBox,
                                  onChanged: (value) {
                                    setState(
                                      () {
                                        cubit.isGroupBox = value ?? false;
                                        cubit.isOnlyBox = false;
                                      },
                                    );
                                  },
                                ),
                                Text(
                                  'شخصي',
                                  style: AppStyle.descriptionStyle.copyWith(
                                    color: Colors.black,
                                    fontSize: screenWidth < 600
                                        ? screenHeight * 0.02
                                        : screenHeight * 0.04,
                                  ),
                                ),
                                Checkbox(
                                  value: cubit.isOnlyBox,
                                  onChanged: (value) {
                                    setState(
                                      () {
                                        cubit.isOnlyBox = value ?? false;
                                        cubit.isGroupBox = false;
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'حضور',
                                  style: AppStyle.descriptionStyle.copyWith(
                                    color: Colors.black,
                                    fontSize: screenWidth < 600
                                        ? screenHeight * 0.02
                                        : screenHeight * 0.04,
                                  ),
                                ),
                                Checkbox(
                                  value: cubit.isRealBox,
                                  onChanged: (value) {
                                    setState(
                                      () {
                                        cubit.isRealBox = value ?? false;
                                        cubit.isOnlineBox = false;
                                      },
                                    );
                                  },
                                ),
                                Text(
                                  'أونلاين',
                                  style: AppStyle.descriptionStyle.copyWith(
                                    color: Colors.black,
                                    fontSize: screenWidth < 600
                                        ? screenHeight * 0.02
                                        : screenHeight * 0.04,
                                  ),
                                ),
                                Checkbox(
                                  value: cubit.isOnlineBox,
                                  onChanged: (value) {
                                    setState(
                                      () {
                                        cubit.isOnlineBox = value ?? false;
                                        cubit.isRealBox = false;
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                            SizedBox(
                              height: screenHeight * 0.04,
                            ),
                            GestureDetector(
                              onTap: () {
                                if (cubit.formKey.currentState!.validate() &&
                                    (cubit.isGroupBox == true ||
                                        cubit.isOnlyBox == true &&
                                            (cubit.isRealBox == true ||
                                                cubit.isOnlineBox == true))) {
                                  cubit.formKey.currentState!.save();

                                  cubit.addNewStudent(
                                    cubit.convertToStudent(
                                        subject: subject, section: section),
                                  );
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return const DailogWidget(
                                          title: 'تم التسجيل بنجاح',
                                          isSuccess: true,
                                        );
                                      });
                                }
                              },
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(16.r),
                                  ),
                                  color: kPrimaryColor,
                                ),
                                child: Center(
                                  child: Text(
                                    'تسجيل',
                                    style: AppStyle.titleStyle.copyWith(
                                      color: Colors.white,
                                      fontSize: screenWidth < 600
                                          ? screenHeight * 0.02
                                          : screenHeight * 0.04,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
