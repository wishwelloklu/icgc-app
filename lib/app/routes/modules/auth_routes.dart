import '../../../features/auth/login/pages/login_page.dart';
import '../../../features/auth/login/pages/login_phone_page.dart';
import '../../../features/auth/login/pages/otp_page.dart';
import '../../../features/auth/sign_up/page/signup_page.dart';
import '../../../features/subscription/presentation/pages/subscription_page.dart';

import '../app_routes.dart';
import '../route_type.dart';

Map<String, RouteType> authRoutes = {
  AppRoutes.login: (context, settings) => const LoginPage(),
  AppRoutes.signup: (context, settings) => const SignupPage(),
  AppRoutes.subscriptionPage: (context, settings) => const SubscriptionPage(),
  AppRoutes.otpPage: (context, settings) => const OtpPage(),
  AppRoutes.loginWithPhone: (context, settings) => const LoginPhonePage(),
};
