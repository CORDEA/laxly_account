import 'dart:async';

import 'package:googleapis/script/v1.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;
import 'package:laxly_account/app_key.dart';
import 'package:url_launcher/url_launcher.dart';

class Authenticator {

  final _scopes = [ScriptApi.SpreadsheetsScope];

  Future<http.Client> authenticate() {
    return clientViaUserConsent(AppKey.id, _scopes, _prompt)
        .then((AuthClient client) {
      return client;
    });
  }

  void _prompt(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}
