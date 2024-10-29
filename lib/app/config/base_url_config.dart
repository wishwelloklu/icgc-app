import 'package:flutter_dotenv/flutter_dotenv.dart';

class BaseUrlConfig {
  static String baseUrlDevelopment = dotenv.env['STAGING_BASE_URL'].toString();
  static String workspaceDevelopment =
      dotenv.env['WORKSPACE_BASE_URL'].toString();
  static String baseUrlProduction =
      dotenv.env['PRODUCTION_BASE_URL'].toString();
  static String callWebSocketUrl = dotenv.env['CALL_WEB_SOCKET_URL'].toString();
  static String subscriptionUrlDevelopment =
      dotenv.env['SUBSCRIPTION_URL'].toString();

// API
  final String rBaseUrl = 'https://rickandmortyapi.com/api';

  final languageAssetsPath = 'assets/resources';
  final githubLink = "https://github.com/developersancho";
  final mediumLink = "https://medium.com/@developersancho";
}
