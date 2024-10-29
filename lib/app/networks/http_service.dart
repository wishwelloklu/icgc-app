import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:either_option/either_option.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:icgc/app/cache/cache_keys.dart';
import 'package:icgc/app/cache/share_preference.dart';
import 'package:icgc/app/error/exception.dart';
import 'package:http/http.dart' as http;

import '../config/base_url_config.dart';
import '../theme/app_string.dart';

class HttpService {
  HttpService._();
  static HttpService instance = HttpService._();

  Uri getURI(String endPoint, [Map<String, dynamic>? parameters]) {
    final url = endPoint.contains(':') ? endPoint.split(':').first : endPoint;

    if (kDebugMode) {
      return Uri.http(
        Platform.isAndroid ? '10.0.2.2' : '192.168.100.63:3004',
        url,
        parameters,
      );
    }
    return Uri.https(BaseUrlConfig.baseUrlDevelopment, url);
  }

  Future<String?> getHeader() async {
    final tokenData = await AppSharedPreferences.instance
        .getShareString(CacheKeys.accessTokeKey);

    if (tokenData != null) {
      print('Bearer ${jsonDecode(tokenData)}');
      return 'Bearer ${jsonDecode(tokenData)}';
    }
    return null;
  }

  //POST request
  Future<Either<CustomException, Map<String, dynamic>>> postRequest({
    required String endPoint,
    required Map<String, dynamic> paylod,
  }) async {
    final accessToken = await getHeader();
    try {
      final response = await http.post(
        getURI(endPoint),
        body: paylod,
        headers: accessToken != null ? {'Authorization': accessToken} : null,
      );
      String data = utf8.decode(response.bodyBytes);
      log(jsonDecode(data).toString());
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return Right(jsonDecode(data));
      }

      return Left(CustomException(jsonDecode(data)['message'].toString()));
    } on PlatformException catch (e) {
      log(e.toString());
      return Left(CustomException(e.message ?? e.code));
    } on TimeoutException catch (e) {
      log(e.toString());
      return Left(
        CustomException(AppString.timeOut),
      );
    } on SocketException catch (e) {
      log(e.toString());
      return Left(CustomException(e.message));
    } catch (e) {
      log(e.toString());
      return Left(CustomException(e.toString()));
    }
  }

  //GET request
  Future<Either<CustomException, Map<String, dynamic>>> getRequest(
      String endPoint,
      [Map<String, dynamic>? parameters]) async {
    final accessToken = await getHeader();
    log(endPoint);
    try {
      final response = await http.get(
        getURI(endPoint, parameters),
        headers: accessToken != null ? {'Authorization': accessToken} : null,
      );
      String data = utf8.decode(response.bodyBytes);
      log(jsonDecode(data).toString());
      if (response.statusCode >= 200 || response.statusCode <= 299) {
        return Right(jsonDecode(data));
      }

      return Left(CustomException(jsonDecode(data)['message'].toString()));
    } on PlatformException catch (e) {
      log(e.toString());
      return Left(CustomException(e.toString()));
    } on TimeoutException catch (e) {
      log(e.toString());
      return Left(
        CustomException(AppString.timeOut),
      );
    } on SocketException catch (e) {
      log(e.toString());
      return Left(CustomException(AppString.timeOut));
    } catch (e) {
      log(e.toString());
      return Left(CustomException(e.toString()));
    }
  }
}
