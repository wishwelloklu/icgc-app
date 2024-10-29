import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icgc/app/routes/app_routes.dart';
import 'package:icgc/app/routes/routes.dart';
import 'package:icgc/init_bloc_provider.dart';

import 'app/config/constant_config.dart';
import 'app/theme/theme.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: getBlocProviders,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: ConstantConfig.appName,
        theme: const CustomTheme(isLight: false).toThemeData(),
        onGenerateRoute: (settings) => Routes.onGenerateRoutes(settings),
        initialRoute: AppRoutes.walkthrough,
      ),
    );
  }
}
