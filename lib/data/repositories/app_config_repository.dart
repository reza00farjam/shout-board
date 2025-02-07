import 'package:shout_board/utils/result.dart';

import '../../domain/models/app_config/app_config_model.dart';
import '../services/local_storage_service.dart';

class AppConfigRepository {
  final LocalStorageService _localStorageService;

  AppConfigRepository({
    required LocalStorageService localStorageService,
  }) : _localStorageService = localStorageService;

  AppConfigModel? _cachedAppConfig;

  Result<AppConfigModel> fetchAppConfig() {
    if (_cachedAppConfig != null) {
      return Result.success(_cachedAppConfig!);
    }

    final result = _localStorageService.fetchAppConfig();

    if (result is Success) _cachedAppConfig = result.asSuccess!.value;

    return result;
  }

  Future<Result> saveAppConfig(AppConfigModel appConfig) async {
    final result = await _localStorageService.saveAppConfig(appConfig);

    if (result is Success) _cachedAppConfig = appConfig;

    return result;
  }
}
