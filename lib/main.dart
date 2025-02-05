import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

import 'config/dependencies.dart';
import 'routing/router.dart';
import 'ui/core/themes/theme.dart';

void main() {
  Logger.root.level = Level.ALL;

  runApp(
    MultiProvider(
      providers: providers,
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router(),
      themeMode: ThemeMode.dark,
      darkTheme: AppTheme.darkTheme,
    );
  }
}
