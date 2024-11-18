import '../app_routes.dart';
import '../../../wrapper.dart';
import '../route_type.dart';

Map<String, RouteType> wrapperRoute = {
  AppRoutes.wrapper: (context, settings) => const Wrapper(),
};
