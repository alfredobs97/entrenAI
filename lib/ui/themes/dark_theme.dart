import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DarkTheme {
  static get theme => ThemeData(
        colorScheme: const ColorScheme(
          background: Color(0XFF212121),
          brightness: Brightness.dark,
          primary: Color(0xFF7D2AE8),
          secondary: Color(0xFFB0FF09),
          error: Colors.red,
          onPrimary: Color(0XFF212121),
          onSecondary: Color(0XFF212121),
          onBackground: Color(0XFF212121),
          onError: Colors.white,
          surface: CupertinoColors.systemGrey,
          onSurface: Colors.black,
        ),
      );
}
