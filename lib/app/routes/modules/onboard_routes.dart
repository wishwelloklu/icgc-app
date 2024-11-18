
import '../../../splash_screen.dart';
import '../../../walkthrough_screen.dart';

import '../app_routes.dart';
import '../route_type.dart';

Map<String, RouteType> onboardRoutes = {
  AppRoutes.splash: (context, settings) => const SplashScreen(),
  AppRoutes.walkthrough: (context, settings) => const WalkthroughScreen(),
};
