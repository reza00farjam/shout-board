import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

import 'config/dependencies.dart';
import 'data/services/local_storage_service.dart';
import 'routing/router.dart';
import 'ui/core/localization/localization.dart';
import 'ui/core/localization/localizations_delegate.dart';
import 'ui/core/themes/theme.dart';
import 'ui/language/view_model/language_viewmodel.dart';

void main() {
  Logger.root.level = Level.ALL;

  runApp(
    MultiProvider(
      providers: providers,
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final _routerConfig = router();

  LanguageViewModel? _languageViewModel;

  @override
  Widget build(BuildContext context) {
    final localStorageService = context.watch<LocalStorageService?>();

    if (localStorageService == null) {
      return MaterialApp(
        themeMode: ThemeMode.dark,
        darkTheme: AppTheme.darkTheme,
        home: const Scaffold(
          // TODO: Replace it with a custom Splash Screen
          body: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    _languageViewModel ??= context.watch();

    return MaterialApp.router(
      themeMode: ThemeMode.dark,
      routerConfig: _routerConfig,
      darkTheme: AppTheme.darkTheme,
      supportedLocales: AppLocalization.supportedLocales,
      onGenerateTitle: (context) => AppLocalization.of(context).title,
      locale: _languageViewModel!.locale ?? Locale(Platform.localeName),
      localeResolutionCallback: AppLocalization.localeResolutionCallback,
      localizationsDelegates: const [
        AppLocalizationsDelegate(),
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
