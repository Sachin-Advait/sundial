import 'dart:async';
import 'get_it.dart';
import 'routes/pages.dart';
import 'utils/global_keys.dart';
import 'constant/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sundial/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  getItSetup();
  configLoading();
  runApp(const MyApp());
}

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.custom
    ..backgroundColor = Colors.white
    ..indicatorColor = Colors.blueAccent
    ..progressColor = Colors.blueAccent
    ..textColor = Colors.black87
    ..maskColor = Colors.white70
    ..userInteractions = true
    ..dismissOnTap = true
    ..radius = 12.0
    ..indicatorSize = 50.0
    ..animationDuration = const Duration(milliseconds: 300);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder:
          (context, BoxConstraints constraints) => ScreenUtilInit(
            designSize: Size(constraints.maxWidth, constraints.maxHeight),
            minTextAdapt: true,
            builder: (context, child) {
              return MaterialApp(
                navigatorKey: GlobalKeys.navigatorKey,
                title: AppStrings.appTitle,
                debugShowCheckedModeBanner: false,
                builder: EasyLoading.init(),
                initialRoute: Pages.getInitialRoute(),
                onGenerateRoute: Pages.onGenerateRoute,
              );
            },
          ),
    );
  }
}
