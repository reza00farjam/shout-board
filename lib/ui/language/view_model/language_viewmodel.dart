import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import '../../../data/repositories/app_config_repository.dart';
import '../../../domain/models/app_config/app_config_model.dart';
import '../../../utils/command.dart';
import '../../../utils/result.dart';

class LanguageViewModel extends ChangeNotifier {
  final AppConfigRepository _appConfigRepository;

  LanguageViewModel({
    required AppConfigRepository appConfigRepository,
  }) : _appConfigRepository = appConfigRepository {
    loadLocale();
    updateLocale = Command1(_updateLocale);
  }

  late Command1<void, Locale?> updateLocale;

  final _log = Logger('LanguageViewModel');

  late AppConfigModel _appConfig;
  Locale? get locale => _appConfig.locale;

  Result loadLocale() {
    try {
      final result = _appConfigRepository.fetchAppConfig();

      switch (result) {
        case Success():
          _appConfig = result.value;
          _log.fine('Loaded locale');
        case Failure():
          _appConfig = AppConfigModel.defaultInstance;
          _log.warning('Failed to load locale', result.error);
      }

      return result;
    } finally {
      notifyListeners();
    }
  }

  Future<Result> _updateLocale(Locale? newLocale) async {
    final newAppConfig = _appConfig.copyWith(locale: newLocale);

    _appConfig = newAppConfig;
    notifyListeners();

    final result = await _appConfigRepository.saveAppConfig(newAppConfig);

    switch (result) {
      case Success():
        _log.fine('Saved locale');
      case Failure():
        _log.warning('Failed to save locale', result.error);
    }

    return result;
  }
}
