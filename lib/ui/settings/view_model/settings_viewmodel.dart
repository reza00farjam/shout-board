import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import '../../../data/repositories/app_config_repository.dart';
import '../../../domain/models/app_config/app_config_model.dart';
import '../../../utils/result.dart';

class SettingsViewModel extends ChangeNotifier {
  final AppConfigRepository _appConfigRepository;

  SettingsViewModel({
    required AppConfigRepository appConfigRepository,
  }) : _appConfigRepository = appConfigRepository {
    loadAppConfig();
  }

  final _log = Logger('SettingsViewModel');

  late AppConfigModel _appConfig;
  AppConfigModel get appConfig => _appConfig;

  Result loadAppConfig() {
    try {
      final result = _appConfigRepository.fetchAppConfig();

      switch (result) {
        case Success():
          _appConfig = result.value;
          _log.fine('Loaded app config');
        case Failure():
          _appConfig = AppConfigModel.defaultInstance;
          _log.warning('Failed to load app config', result.error);
      }

      return result;
    } finally {
      notifyListeners();
    }
  }
}
