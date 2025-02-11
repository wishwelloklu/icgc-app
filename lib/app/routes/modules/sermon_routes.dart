import 'package:icgc/features/sermons/pages/sample_details.dart';

import '../app_routes.dart';
import '../route_type.dart';

Map<String, RouteType> sermonRoutes = {
  AppRoutes.sampleDetails: (context, settings) => const SampleDetails(),
};
