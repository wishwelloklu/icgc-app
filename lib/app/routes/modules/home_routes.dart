import '../../../features/home_page/pages/continue_reading.dart';
import '../../../features/home_page/pages/home_page.dart';

import '../app_routes.dart';
import '../route_type.dart';

Map<String, RouteType> homeRoutes = {
  AppRoutes.home: (context, settings) => const HomePage(),
  AppRoutes.continueReading: (context, settings) => const ContinueReading(),
};
