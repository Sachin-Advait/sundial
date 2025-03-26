import '../../routes/routes.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:sundial/utils/global_keys.dart';
import 'package:sundial/constant/app_assets.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 2),
    ).then((_) => _checkAuthStateAndNavigate());
    super.initState();
  }

  void _checkAuthStateAndNavigate() {
    GlobalKeys.navigatorKey.currentState!.pushReplacementNamed(Routes.LOGIN);
    // Check if user is authenticated
    // If authenticated, navigate to home
    // else navigate to login
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: Lottie.asset(AppAssetsAnimations.splashAnimation));
  }
}
