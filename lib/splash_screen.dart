import 'package:flutter/material.dart';
import 'app/routes/app_routes.dart';
import 'app/routes/route_navigator.dart';
import 'app/theme/app_color.dart';
import 'app/theme/app_images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2)).then((_) {
      routeAndRemoveNavigator(context, AppRoutes.walkthrough);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Center(child: Image.asset(AppImages.logoIcon, scale: 2)),
    );
  }
}
