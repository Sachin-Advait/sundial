import 'dart:async';
import 'get_it.dart';
import 'routes/pages.dart';
import 'utils/global_keys.dart';
import 'constant/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  getItSetup();
  runApp(const MyApp());
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
                builder: (context, widget) {
                  EasyLoading.instance
                    ..indicatorType = EasyLoadingIndicatorType.doubleBounce
                    ..loadingStyle = EasyLoadingStyle.light
                    ..indicatorSize = 45.0
                    ..radius = 10.0
                    ..progressColor = Colors.yellow
                    ..backgroundColor = Colors.green
                    ..indicatorColor = Colors.yellow
                    ..textColor = Colors.yellow
                    ..userInteractions = false
                    ..dismissOnTap = false;

                  return EasyLoading.init()(context, widget);
                },
                initialRoute: Pages.getInitialRoute(),
                onGenerateRoute: Pages.onGenerateRoute,
              );
            },
          ),
    );
  }
}
