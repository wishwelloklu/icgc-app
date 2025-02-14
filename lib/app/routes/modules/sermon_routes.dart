import 'package:icgc/features/sermons/pages/add_tag.dart';
import 'package:icgc/features/sermons/pages/sermon_details.dart';
import 'package:icgc/features/text_editor/pages/text_editor.dart';

import '../app_routes.dart';
import '../route_type.dart';

Map<String, RouteType> sermonRoutes = {
  AppRoutes.sermonDetails: (context, settings) => const SermonDetails(),
  AppRoutes.textEditor: (context, settings) => const TextEditor(),
  AppRoutes.newSermon: (context, settings) => const AddTag(),
};
