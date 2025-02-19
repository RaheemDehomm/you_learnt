import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:learnt_app/helper/class/section_extra.dart';

import 'package:learnt_app/helper/routes/app_routes.dart';
import 'package:learnt_app/helper/style/const_style.dart';
import 'package:learnt_app/logic/learnt_cubit.dart';

import 'package:learnt_app/presentation/widgets/section_card_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../widgets/dailog_widget.dart';

class HomeWebView extends StatelessWidget {
  const HomeWebView({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final cubit = context.read<LearntCubit>();

    cubit.fetchSections();

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.02, vertical: screenHeight * 0.01),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                color: Colors.white,
                height: screenHeight * 0.10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/images/logo_you_learnt.png',
                      width: screenWidth * 0.15,
                      fit: BoxFit.cover,
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        ButtomWebView(
                            title: 'حدد مستواك',
                            onTap: () {
                              context.goNamed(
                                AppRoutes.examSart,
                                extra: SectionExtra(
                                  section: '',
                                  isHasExam: false,
                                ),
                              );
                            }),
                        ButtomWebView(
                          title: 'زورنا',
                          onTap: () async {
                            if (await canLaunchUrl(
                                Uri.parse('https://youlearnt.com/ar/'))) {
                              await launchUrl(
                                Uri.parse('https://youlearnt.com/ar/'),
                              );
                            } else {
                              const DailogWidget(
                                title: 'حدث خطأ ',
                                isSuccess: false,
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.1),
              LayoutBuilder(
                builder: (context, constraints) {
                  bool isSmallScreen = constraints.maxWidth < 600;

                  return Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                    child: isSmallScreen
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/undraw_hello_ccwj.png',
                                height: screenHeight * 0.25,
                                fit: BoxFit.contain,
                              ),
                              SizedBox(height: screenHeight * 0.02),
                              Text(
                                'هدفنا جعل التعليم والتعلم سهلا لأي مادة على أي شخص بأي لغة وفي أي وقت ومن أي مكان',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: screenWidth * 0.04,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: kFontFamily,
                                ),
                              ),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/undraw_hello_ccwj.png',
                                height: screenHeight * 0.3,
                                fit: BoxFit.contain,
                              ),
                              SizedBox(width: screenWidth * 0.02),
                              Expanded(
                                child: Text(
                                  'هدفنا جعل التعليم والتعلم سهلا لأي مادة على أي شخص بأي لغة وفي أي وقت ومن أي مكان',
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                    fontSize: screenWidth * 0.02,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: kFontFamily,
                                  ),
                                ),
                              ),
                            ],
                          ),
                  );
                },
              ),
              SizedBox(height: screenHeight * 0.01),
              Container(
                width: double.infinity,
                color: kPrimaryColor,
                padding: EdgeInsets.all(screenWidth * 0.02),
                child: Column(
                  children: [
                    Text(
                      'الأقسام',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth * 0.02,
                        fontWeight: FontWeight.bold,
                        fontFamily: kFontFamily,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    SizedBox(
                      //height: screenHeight * 0.4, // ارتفاع القائمة
                      child: BlocBuilder<LearntCubit, LearntState>(
                        builder: (context, state) {
                          if (state is LearntLoadSectionFailure) {
                            return Center(
                              child: Text(
                                state.message,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: screenWidth * 0.02,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: kFontFamily,
                                ),
                              ),
                            );
                          }
                          if (state is LearntLoadSectionSuccess) {
                            return GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: screenWidth > 600
                                    ? MediaQuery.of(context).size.width / 4
                                    : MediaQuery.of(context).size.width / 2,
                                crossAxisSpacing:
                                    MediaQuery.of(context).size.width *
                                        0.01, // المسافة الأفقية بين العناصر
                                mainAxisSpacing:
                                    MediaQuery.of(context).size.height *
                                        0.02, // المسافة العمودية بين العناصر
                                childAspectRatio:
                                    MediaQuery.of(context).size.width < 600
                                        ? 0.8
                                        : 1.2, // ضبط النسبة حسب الجهاز
                              ),
                              itemCount: state.sections.length,
                              itemBuilder: (context, index) {
                                return SectionCardWidget(
                                  title: state.sections[index].name,
                                  imageurl: state.sections[index].image,
                                  fontSize: screenWidth < 600
                                      ? screenHeight * 0.02
                                      : screenHeight * 0.01,
                                  onTap: () {
                                    context.goNamed(
                                      AppRoutes.courseWeb,
                                      extra: state.sections[index].name,
                                    );
                                  },
                                );
                              },
                            );
                          }
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ButtomWebView extends StatefulWidget {
  const ButtomWebView({super.key, this.title, this.onTap});

  final String? title;
  final void Function()? onTap;

  @override
  State<ButtomWebView> createState() => _ButtomWebViewState();
}

class _ButtomWebViewState extends State<ButtomWebView> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.005),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: isHovered ? kPrimaryColor : Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 0,
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.02,
              vertical: screenWidth * 0.015,
            ),
          ),
          onPressed: widget.onTap ?? () {},
          child: Text(
            widget.title ?? 'الدورات',
            style: TextStyle(
              color: isHovered ? Colors.white : Colors.grey[700],
              fontSize:
                  screenWidth < 600 ? screenWidth * 0.04 : screenWidth * 0.02,
              fontWeight: FontWeight.bold,
              fontFamily: kFontFamily,
            ),
          ),
        ),
      ),
    );
  }
}
