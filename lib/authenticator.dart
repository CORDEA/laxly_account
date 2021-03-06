import 'dart:async';

import 'package:googleapis/script/v1.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;
import 'package:laxly_account/app_key.dart';
import 'package:url_launcher/url_launcher.dart';

class Authenticator {
  final _scopes = [ScriptApi.SpreadsheetsScope];

  Future<AuthClient> authenticate() {
    return clientViaUserConsent(AppKey.ID, _scopes, _prompt)
        .then((AuthClient client) {
      return client;
    });
  }

  http.Client getClient(AccessCredentials credentials) {
    return autoRefreshingClient(AppKey.ID, credentials, new http.Client());
  }

  void _prompt(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}
