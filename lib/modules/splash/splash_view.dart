import '../../routes/routes.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:sundial/utils/global_keys.dart';
import 'package:sundial/constant/app_assets.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    _checkAuthStateAndNavigate();
    super.initState();
  }

  Future<void> _checkAuthStateAndNavigate() async {
    await Future.delayed(Duration(seconds: 2));

    User? user = FirebaseAuth.instance.currentUser;

    GlobalKeys.navigatorKey.currentState!.pushReplacementNamed(
      user == null ? Routes.LOGIN : Routes.DASHBOARD,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: Lottie.asset(AppAssetsAnimations.splashAnimation));
  }
}
