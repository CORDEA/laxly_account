import 'package:flutter/material.dart';
import 'package:laxly_account/colors.dart';

class LaxlyTheme {
  final ThemeData _base = ThemeData.light();

  ThemeData get lightTheme => ThemeData.light().copyWith(
      primaryColor: PRIMARY_COLOR,
      buttonColor: PRIMARY_COLOR,
      primaryTextTheme: _textTheme,
      primaryIconTheme: _base.iconTheme.copyWith(color: PRIMARY_TEXT_COLOR),
      accentColor: SECONDARY_COLOR,
      textSelectionColor: PRIMARY_COLOR,
      buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.normal),
      textSelectionHandleColor: PRIMARY_COLOR,
      accentTextTheme: _textTheme);

  TextTheme get _textTheme => _base.textTheme
      .apply(displayColor: PRIMARY_TEXT_COLOR, bodyColor: PRIMARY_TEXT_COLOR);
}
