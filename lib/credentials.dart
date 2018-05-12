import 'dart:async';

import 'package:googleapis_auth/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Credentials {
  static const _ACCESS_TOKEN_TYPE_KEY = "ACCESS_TOKEN_TYPE_KEY";
  static const _ACCESS_TOKEN_DATA_KEY = "ACCESS_TOKEN_DATA_KEY";
  static const _ACCESS_TOKEN_EXPIRY_KEY = "ACCESS_TOKEN_EXPIRY_KEY";
  static const _REFRESH_TOKEN_KEY = "REFRESH_TOKEN_KEY";
  static const _SCOPES_KEY = "SCOPES_KEY";

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  void save(AccessCredentials credentials) async {
    var prefs = await _prefs;
    await prefs.setString(_ACCESS_TOKEN_DATA_KEY, credentials.accessToken.data);
    await prefs.setString(_ACCESS_TOKEN_EXPIRY_KEY,
        credentials.accessToken.expiry.toIso8601String());
    await prefs.setString(_ACCESS_TOKEN_TYPE_KEY, credentials.accessToken.type);
    await prefs.setString(_REFRESH_TOKEN_KEY, credentials.refreshToken);
    await prefs.setStringList(_SCOPES_KEY, credentials.scopes);
  }

  Future<AccessCredentials> load() async {
    var prefs = await _prefs;
    var keys = prefs.getKeys();
    if (!keys.contains(_ACCESS_TOKEN_DATA_KEY)) {
      throw Exception();
    }

    var token = new AccessToken(
        prefs.getString(_ACCESS_TOKEN_TYPE_KEY),
        prefs.getString(_ACCESS_TOKEN_DATA_KEY),
        DateTime.parse(prefs.getString(_ACCESS_TOKEN_EXPIRY_KEY)));
    return AccessCredentials(token, prefs.getString(_REFRESH_TOKEN_KEY),
        prefs.getStringList(_SCOPES_KEY));
  }
}
