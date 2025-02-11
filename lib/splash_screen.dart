import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app/routes/app_routes.dart';
import 'app/routes/route_navigator.dart';
import 'app/theme/app_color.dart';
import 'app/theme/app_images.dart';
import 'features/notifications/data/bloc/notification_bloc.dart';
import 'features/notifications/data/bloc/notification_events.dart';
import 'features/sermons/data/bloc/sample_bloc/sample_bloc.dart';
import 'features/sermons/data/bloc/sample_bloc/sample_events.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2)).then((_) {
      context.read<SampleBloc>().add(LoadSample());
      context.read<NotificationBloc>().add(LoadNotifications());
      routeAndRemoveNavigator(context, AppRoutes.wrapper);
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
