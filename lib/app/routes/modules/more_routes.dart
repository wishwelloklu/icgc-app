
import 'package:icgc/features/library/presentation/pages/library_page.dart';

import '../app_routes.dart';
import '../route_type.dart';

Map<String, RouteType> moreRoutes = {
  AppRoutes.library: (context, settings) => const LibraryPage(),
};
