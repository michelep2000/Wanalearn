import 'package:flutter/material.dart';
import 'package:wanalearn/core/config/router/app_router.dart';
import 'package:wanalearn/core/config/theme/app_theme.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Wanalearn',
      theme: AppTheme.getTheme(),
      routerConfig: goRouter,
    );
  }
}
