import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:laxly_account/authenticator.dart';
import 'package:laxly_account/main_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage() {
    _pressedStream.stream.listen(_onPressed);
  }

  final _authenticator = new Authenticator();

  final _pressedStream = new StreamController<BuildContext>();

  void _onPressed(BuildContext context) async {
    http.Client client = await _authenticator.authenticate();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => new MainPage(client)));
  }

  @override
  Widget build(BuildContext context) {
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
