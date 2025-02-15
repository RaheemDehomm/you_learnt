import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:learnt_app/helper/class/section_extra.dart';
import 'package:learnt_app/helper/routes/app_routes.dart';
import 'package:learnt_app/helper/style/app_style.dart';
import 'package:learnt_app/logic/learnt_cubit.dart';
import 'package:learnt_app/presentation/views/web/home_web_view.dart';
import 'package:learnt_app/presentation/widgets/dailog_widget.dart';
import 'package:learnt_app/presentation/widgets/info_widget.dart';
import 'package:learnt_app/presentation/widgets/section_card_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    var cubbit = context.watch<LearntCubit>();

    if (kIsWeb) {
      return const HomeWebView();
    } else {
      return SafeArea(
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 14.h),
            child: Column(
              children: [
                Infowidget(
                  onTap: () async {
                    if (await canLaunchUrl(
                        Uri.parse('https://youlearnt.com/ar/'))) {
                      await launchUrl(Uri.parse('https://youlearnt.com/ar/'));
                    } else {
                      const DailogWidget(
                        title: 'حدث خطأ ',
                        isSuccess: false,
                      );
                    }
                  },
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Text(
                      'الأقسام',
                      style: AppStyle.titleStyle,
                    ),
                    SizedBox(width: 10.w),
                    Image.asset(
                      'assets/images/undraw_online-learning_tgmv.png',
                      height: 70.h,
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Expanded(
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: cubbit.sections.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 4.w, vertical: 4.h),
                              child: BlocBuilder<LearntCubit, LearntState>(
                                builder: (context, state) {
                                  if (state is LearntLoadSectionSuccess) {
                                    return SectionCardWidget(
                                      imageurl: state.sections[index].image,
                                      title: state.sections[index].name,
                                      fontSize: 22,
                                      onTap: () {
                                        context.goNamed(
                                          AppRoutes.course,
                                          extra: SectionExtra(
                                            section: state.sections[index].name,
                                            isHasExam:
                                                state.sections[index].isHasExam,
                                          ),
                                        );
                                      },
                                    );
                                  }
                                  if (state is LearntLoadSectionFailure) {
                                    return Text(
                                      state.message,
                                      style: AppStyle.titleStyle,
                                    );
                                  }
                                  return const CircularProgressIndicator();
                                },
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
