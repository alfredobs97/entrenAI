import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LightTheme {
  static get theme => ThemeData(
        colorScheme: const ColorScheme(
          background: Colors.white,
          brightness: Brightness.dark,
          primary: Color(0xFF7D2AE8),
          secondary: Color(0xFFB0FF09),
          error: Colors.red,
          onPrimary: Colors.black,
          onSecondary: Colors.black,
          onBackground: Colors.black,
          onError: Colors.white,
          surface: CupertinoColors.systemGrey,
          onSurface: Colors.black,
        ),
        useMaterial3: true,
      );
}
