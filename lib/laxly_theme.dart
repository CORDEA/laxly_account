import 'package:flutter/material.dart';
import 'package:laxly_account/colors.dart';

class LaxlyTheme {
  final ThemeData _base = ThemeData.light();

  ThemeData get lightTheme => ThemeData.light().copyWith(
      primaryColor: PRIMARY_COLOR,
      buttonColor: PRIMARY_COLOR,
      primaryTextTheme: _textTheme,
      primaryIconTheme: _base.iconTheme.copyWith(color: SECONDARY_DARK_COLOR),
      accentColor: SECONDARY_COLOR,
      textSelectionColor: SECONDARY_DARK_COLOR,
      buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.normal),
      textSelectionHandleColor: PRIMARY_COLOR,
      accentTextTheme: _textTheme);

  TextTheme get _textTheme => _base.textTheme.apply(
      displayColor: SECONDARY_DARK_COLOR, bodyColor: SECONDARY_DARK_COLOR);
}
