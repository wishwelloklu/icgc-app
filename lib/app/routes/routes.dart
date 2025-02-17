import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icgc/app/routes/modules/sermon_routes%20copy.dart';
import 'package:icgc/core/presentation/epub_reader.dart';
import 'package:icgc/features/others/pages/others_details.dart';
import 'package:icgc/features/prayer/pages/prayer_details.dart';
import 'app_routes.dart';
import 'modules/auth_routes.dart';
import 'modules/home_routes.dart';
import 'modules/manual_routes.dart';
import 'modules/more_routes.dart';
import 'modules/onboard_routes.dart';
import 'modules/sermon_routes.dart';
import 'route_type.dart';

import 'modules/wrapper_routes.dart';

class Routes {
  static Map<String, RouteType> _resolveRoutes() {
    return {
        AppRoutes.epub: (context, settings) => const EpubReader(),
        AppRoutes.prayerDetails: (context, settings) => const PrayerDetails(),
      AppRoutes.othersDetails: (context, settings) => const OthersDetails(),
      ...onboardRoutes,
      ...authRoutes,
      ...onboardRoutes,
      ...homeRoutes,
      ...wrapperRoute,
      ...manualRoute,
      ...moreRoutes,
      ...sermonRoutes,
      ...declarationRoutes,
    };
  }

  static Route onGenerateRoutes(RouteSettings settings) {
    var routes = _resolveRoutes();
    final RouteType? child = routes[settings.name];

    if (child == null) {
      throw const FormatException("--- Route doesn't exist");
    }

    Widget builder(BuildContext context) {
      return child(context, settings);
    }

    if (Platform.isIOS) {
      return CupertinoPageRoute(
        builder: (context) => builder(context),
        settings: settings,
      );
    } else {
      return MaterialPageRoute(
        builder: (context) => builder(context),
        settings: settings, // Pass settings including arguments
      );
    }
  }
}
