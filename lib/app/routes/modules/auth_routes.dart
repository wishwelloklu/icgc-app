

import 'package:icgc/features/auth/login/pages/login_page.dart';
import 'package:icgc/features/auth/sign_up/page/signup_page.dart';
import 'package:icgc/features/subscription/presentation/pages/subscription_page.dart';

import '../app_routes.dart';
import '../route_type.dart';

Map<String, RouteType> authRoutes = {
  AppRoutes.login: (context, settings) => const LoginPage(),
  AppRoutes.signup: (context, settings) => const SignupPage(),
  AppRoutes.subscriptionPage: (context, settings) => const SubscriptionPage(),
};
