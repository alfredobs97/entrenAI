import 'package:entrenai/logs/app_bloc_observer.dart';
import 'package:entrenai/ui/app_router.dart';
import 'package:entrenai/ui/themes/dark_theme.dart';
import 'package:entrenai/ui/themes/light_teme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  Bloc.observer = AppBlocObserver();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EntrenAI',
      debugShowCheckedModeBanner: false,
      darkTheme: DarkTheme.theme,
      theme: LightTheme.theme,
      onGenerateRoute: AppRouter().generateRoute,
      initialRoute: AppRouter.getNestedRouteName(),
    );
  }
}
