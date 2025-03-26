import 'routes.dart';
import '../get_it.dart';
import 'default_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../modules/dashboard/dashboard_provider.dart';
import 'package:sundial/modules/login/login_view.dart';
import 'package:sundial/modules/splash/splash_view.dart';
import 'package:sundial/modules/login/login_provider.dart';
import 'package:sundial/modules/dashboard/dashboard_view.dart';

class Pages {
  static String getInitialRoute() => Routes.SPLASH;

  static PageRouteBuilder _buildRoutes(
    Widget child, {
    required RouteSettings? settings,
  }) {
    return PageRouteBuilder(
      transitionsBuilder:
          (_, oppacity, __, widget) =>
              FadeTransition(opacity: oppacity, child: widget),
      pageBuilder: (_, __, ___) => child,
      settings: settings,
    );
  }

  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.SPLASH:
        return _buildRoutes(const SplashView(), settings: settings);

      case Routes.LOGIN:
        return _buildRoutes(
          Provider(
            create: (_) => getIt.get<LoginProvider>(),
            child: const LoginView(),
          ),
          settings: settings,
        );

      case Routes.DASHBOARD:
        return _buildRoutes(
          ChangeNotifierProvider(
            create: (_) => getIt.get<DashboardProvider>(),
            child: DashboardView(),
          ),

          settings: settings,
        );

      default:
        return _buildRoutes(const DefaultRoute(), settings: settings);
    }
  }
}
