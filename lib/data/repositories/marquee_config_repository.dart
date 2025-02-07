import '../../domain/models/marquee_config/marquee_config_model.dart';
import '../../utils/result.dart';
import '../services/local_storage_service.dart';

class MarqueeConfigRepository {
  final LocalStorageService _localStorageService;

  MarqueeConfigRepository({
    required LocalStorageService localStorageService,
  }) : _localStorageService = localStorageService;

  MarqueeConfigModel? _cachedMarqueeConfig;

  Result<MarqueeConfigModel> fetchMarqueeConfig() {
    if (_cachedMarqueeConfig != null) {
      return Result.success(_cachedMarqueeConfig!);
    }

    final result = _localStorageService.fetchMarqueeConfig();

    if (result is Success) _cachedMarqueeConfig = result.asSuccess!.value;

    return result;
  }

  Future<Result> saveMarqueeConfig(MarqueeConfigModel marqueeConfig) async {
    final result = await _localStorageService.saveMarqueeConfig(marqueeConfig);

    if (result is Success) _cachedMarqueeConfig = marqueeConfig;

    return result;
  }
}
