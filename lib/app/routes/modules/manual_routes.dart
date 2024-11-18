import '../../../features/manual/pages/name_variable_inserting.dart';
import '../../../features/manual/pages/officiating_list.dart';
import '../../../features/reader_page/presentation/pages/reader_page.dart';
import '../../../features/reader_page/presentation/pages/variable_read_page.dart';

import '../app_routes.dart';
import '../route_type.dart';

Map<String, RouteType> manualRoute = {
  AppRoutes.readerPage: (context, settings) => const ReaderPage(),
  AppRoutes.officiateList: (context, settings) => const OfficiatingList(),
  AppRoutes.nameVariableInserting: (context, settings) =>
      const NameVariableInserting(),
  AppRoutes.variableReadPage: (context, settings) => const VariableReadPage(),
};
