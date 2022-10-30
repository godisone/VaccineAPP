import 'dart:convert';

import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:flutter/cupertino.dart';

import '../models/login_response_model.dart';

LoginResponseModel loginResponseJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

class SharedService {
  static const String KEY_NAME = "login_key";

  static Future<bool> isLoggedIn() async {
    var isCacheKeyExist = await APICacheManager().isAPICacheKeyExist(KEY_NAME);

    return isCacheKeyExist;
  }

  static Future<void> setLoginDetails(
    LoginResponseModel loginResponse,
  ) async {
    APICacheDBModel cacheModel = APICacheDBModel(
      key: KEY_NAME,
      syncData: jsonEncode(loginResponse.toJson()),
    );

    await APICacheManager().addCacheData(cacheModel);
  }

  static Future<LoginResponseModel?> loginDetails() async {
    var isCacheKeyExist = await APICacheManager().isAPICacheKeyExist(KEY_NAME);

    if (isCacheKeyExist) {
      var cacheData = await APICacheManager().getCacheData(KEY_NAME);

      return loginResponseJson(cacheData.syncData);
    }
  }

  static Future<void> logout(BuildContext context) async {
    await APICacheManager().deleteCache(KEY_NAME);
    // ignore: use_build_context_synchronously
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/login',
      (route) => false,
    );
  }
}
