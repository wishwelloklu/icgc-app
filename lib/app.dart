import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icgc/orientation_lock.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
// import 'package:icgc/app/routes/route_navigator.dart';
import 'app/config/navigation_key.dart';
import 'app/routes/app_routes.dart';
import 'app/routes/routes.dart';
import 'init_bloc_provider.dart';

import 'app/config/constant_config.dart';
import 'app/theme/theme.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    initialization();
    
    super.initState();
  }

  void initialization() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(const Duration(seconds: 2)).then((_) {
        // FlutterNativeSplash.remove();
        // if (mounted) {
        //   currentState?.pushNamedAndRemoveUntil(
        //       AppRoutes.walkthrough, (route) => false);
        // }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: getBlocProviders,
      child: OrientationLock(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: ConstantConfig.appName,
          scaffoldMessengerKey: AppNavigatorKeys.instance.scaffoldKey,
          navigatorKey: AppNavigatorKeys.instance.navigatorKey,
          theme: const CustomTheme(isLight: true).toThemeData(),
          onGenerateRoute: (settings) => Routes.onGenerateRoutes(settings),
          initialRoute: AppRoutes.splash,
        ),
      ),
    );
  }
}
