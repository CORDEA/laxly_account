import 'dart:async';

import 'package:googleapis/drive/v2.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:laxly_account/key.dart';
import 'package:url_launcher/url_launcher.dart';

class Authenticator {

  final _scopes = [DriveApi.DriveScope];

  Future<AccessToken> authenticate() {
    return clientViaUserConsent(Key.id, _scopes, _prompt)
        .then((AuthClient client) {
      var token = client.credentials.accessToken;
      client.close();
      return token;
    });
  }

  void _prompt(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}
