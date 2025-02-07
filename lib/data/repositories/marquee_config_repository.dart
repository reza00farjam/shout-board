import '../../domain/models/marquee/marquee_config_model.dart';
import '../../utils/result.dart';
import '../services/local_storage_service.dart';

class MarqueeConfigRepository {
  final LocalStorageService _localStorageService;

  MarqueeConfigRepository({
    required LocalStorageService localStorageService,
  }) : _localStorageService = localStorageService;

  MarqueeConfigModel? _cachedMarqueeConfig;

  Future<Result<MarqueeConfigModel>> fetchMarqueeConfig() async {
    if (_cachedMarqueeConfig != null) {
      return Future.value(Result.success(_cachedMarqueeConfig!));
    }

    final result = await _localStorageService.fetchMarqueeConfig();

    if (result is Success) _cachedMarqueeConfig = result.asSuccess!.value;

    return result;
  }

  Future<Result<void>> saveMarqueeConfig(
    MarqueeConfigModel marqueeConfig,
  ) async {
    final result = await _localStorageService.saveMarqueeConfig(marqueeConfig);

    if (result is Success) _cachedMarqueeConfig = marqueeConfig;

    return result;
  }
}
