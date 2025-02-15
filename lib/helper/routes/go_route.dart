import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:learnt_app/helper/class/register_extra.dart';
import 'package:learnt_app/helper/class/section_extra.dart';
import 'package:learnt_app/helper/routes/app_routes.dart';
import 'package:learnt_app/logic/question_cubit.dart';
import 'package:learnt_app/presentation/views/phone/course_view.dart';
import 'package:learnt_app/presentation/views/phone/exam_sart_view.dart';
import 'package:learnt_app/presentation/views/phone/exam_view.dart';
import 'package:learnt_app/presentation/views/phone/home_view.dart';
import 'package:learnt_app/presentation/views/phone/register_view.dart';
import 'package:learnt_app/presentation/views/web/course_web.view.dart';
import 'package:learnt_app/presentation/views/web/home_web_view.dart';

class GoRoutes {
  static GoRouter router = GoRouter(
    initialLocation: AppRoutes.home,
    routes: <RouteBase>[
      GoRoute(
        path: AppRoutes.home,
        name: AppRoutes.home,
        builder: (BuildContext context, GoRouterState state) {
          return const HomeView();
        },
      ),
      GoRoute(
        path: AppRoutes.homeWeb,
        name: AppRoutes.homeWeb,
        builder: (BuildContext context, GoRouterState state) {
          return const HomeWebView();
        },
      ),
      GoRoute(
        path: AppRoutes.course,
        name: AppRoutes.course,
        builder: (BuildContext context, GoRouterState state) {
          final SectionExtra sectionExtra = state.extra as SectionExtra;
          return CourseView(
            sectionExtra: sectionExtra,
          );
        },
      ),
      GoRoute(
        path: AppRoutes.courseWeb,
        name: AppRoutes.courseWeb,
        builder: (BuildContext context, GoRouterState state) {
          final String? section = state.extra as String?;
          return CourseWebView(
            section: section ?? '',
          );
        },
      ),
      GoRoute(
        path: AppRoutes.register,
        name: AppRoutes.register,
        builder: (BuildContext context, GoRouterState state) {
          RegisterExtra? extra = state.extra as RegisterExtra?;
          return RegisterView(
            section: extra?.section,
            subject: extra?.subject,
          );
        },
      ),
      GoRoute(
        path: AppRoutes.examSart,
        name: AppRoutes.examSart,
        builder: (BuildContext context, GoRouterState state) {
          final SectionExtra? sectionExtra = state.extra as SectionExtra?;
          return BlocProvider(
            create: (context) => QuestionCubit(),
            child: ExamSartView(
              sectionExtra: sectionExtra,
            ),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.exam,
        name: AppRoutes.exam,
        builder: (BuildContext context, GoRouterState state) {
          final String? section = state.extra as String?;
          return BlocProvider(
            create: (context) => QuestionCubit(),
            child: ExamView(
              section: section,
            ),
          );
        },
      ),
    ],
  );
}
