import '../../domain/models/marquee/marquee_model.dart';
import '../../utils/result.dart';
import '../services/local_storage_service.dart';

class MarqueeRepository {
  final LocalStorageService _localStorageService;

  MarqueeRepository({
    required LocalStorageService localStorageService,
  }) : _localStorageService = localStorageService;

  MarqueeModel? _cachedMarquee;

  Future<Result<MarqueeModel>> fetchMarquee() async {
    if (_cachedMarquee != null) {
      return Future.value(Result.success(_cachedMarquee!));
    }

    final result = await _localStorageService.fetchMarquee();

    if (result is Success) {
      _cachedMarquee = (result as Success).value;
    }

    return result;
  }

  Future<Result<void>> saveMarquee(MarqueeModel marquee) async {
    final result = await _localStorageService.saveMarquee(marquee);

    if (result is Success) {
      _cachedMarquee = marquee;
    }

    return result;
  }
}
