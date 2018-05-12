import 'package:flutter/material.dart';
import 'package:laxly_account/laxly_theme.dart';
import 'package:laxly_account/login_page.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  final LaxlyTheme _theme = LaxlyTheme();

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: _theme.lightTheme,
      home: new LoginPage(),
    );
  }
}
