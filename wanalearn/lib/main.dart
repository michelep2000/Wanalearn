import 'package:flutter/material.dart';
import 'package:wanalearn/core/config/router/app_router.dart';
import 'package:wanalearn/core/config/theme/app_theme.dart';
import 'package:wanalearn/core/di/dependency_injection.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await injectDependencies();
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
