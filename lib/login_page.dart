import 'dart:async';

import 'package:flutter/material.dart';
import 'package:googleapis_auth/auth.dart';
import 'package:http/http.dart' as http;
import 'package:laxly_account/authenticator.dart';
import 'package:laxly_account/credentials.dart';
import 'package:laxly_account/main_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage() {
    _pressedStream.stream.listen(_onPressed);
  }

  final _credentials = new Credentials();

  final _authenticator = new Authenticator();

  final _pressedStream = new StreamController<BuildContext>();

  void _onPressed(BuildContext context) async {
    AuthClient client = await _authenticator.authenticate();
    _credentials.save(client.credentials);
    _navigateToMain(context, client);
  }

  void _navigateToMain(BuildContext context, http.Client client) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => new MainPage(client)));
  }

  @override
  Widget build(BuildContext context) {
    _credentials.load().then((value) {
      var client = _authenticator.getClient(value);
      _navigateToMain(context, client);
    }).catchError((err) {});

    return Scaffold(
        appBar: AppBar(
          title: Text("Login"),
        ),
        body: Center(
            child: RaisedButton(
                child: Text("START AUTHENTICATION"),
                onPressed: () {
                  _pressedStream.add(context);
                })));
  }
}
