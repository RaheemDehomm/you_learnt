import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:learnt_app/helper/routes/go_route.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:learnt_app/logic/learnt_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://jkpqnpbtfghgxthpdxai.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImprcHFucGJ0ZmdoZ3h0aHBkeGFpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzkwMjE5MjEsImV4cCI6MjA1NDU5NzkyMX0.SyQ4Ga-L-nCD_e9ZdPnEU0KcCN0aWlisw9XYhLjT-lk',
  );

  runApp(BlocProvider(
    create: (context) => LearntCubit(),
    child: const YouLearntApp(),
  ));
}

class YouLearntApp extends StatelessWidget {
  const YouLearntApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          locale: const Locale('ar'),
          supportedLocales: const [
            Locale('ar', ''),
          ],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFffffff)),
          routerConfig: GoRoutes.router,
          builder: (context, child) {
            return OfflineBuilder(
              connectivityBuilder: (
                BuildContext context,
                List<ConnectivityResult> connectivity,
                Widget? child,
              ) {
                final bool connected =
                    !connectivity.contains(ConnectivityResult.none);
                return Scaffold(
                  body: connected
                      ? child ?? const SizedBox()
                      : Center(
                          child: Text(
                            '...تأكد من الإتصال بالإنترنت',
                            style: TextStyle(
                              fontSize: 20.sp,
                            ),
                          ),
                        ),
                );
              },
              child: child,
            );
          },
        );
      },
    );
  }
}
