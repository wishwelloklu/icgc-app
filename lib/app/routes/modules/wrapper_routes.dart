import 'package:icgc/app/routes/app_routes.dart';
import 'package:icgc/wrapper.dart';
import '../route_type.dart';

Map<String, RouteType> wrapperRoute = {
  AppRoutes.wrapper: (context, settings) => const Wrapper(),
};
