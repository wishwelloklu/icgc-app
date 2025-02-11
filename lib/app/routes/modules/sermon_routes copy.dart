
import '../../../features/theme/pages/theme_details.dart';
import '../app_routes.dart';
import '../route_type.dart';

Map<String, RouteType> declarationRoutes = {
  AppRoutes.themeDetails: (context, settings) => const ThemeDetails(),
};
