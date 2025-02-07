import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/models/marquee/marquee_config_model.dart';
import '../../utils/result.dart';

class LocalStorageService {
  static const _blinkKey = 'BLINK';
  static const _mirrorKey = 'MIRROR';
  static const _messageKey = 'MESSAGE';
  static const _sizeKey = 'SIZE';
  static const _velocityKey = 'VELOCITY';
  static const _messageColorKey = 'MESSAGE_COLOR';
  static const _backgroundColorKey = 'BACKGROUND_COLOR';
  static const _scrollDirectionKey = 'SCROLL_DIRECTION';
  static const _messageDirectionKey = 'MESSAGE_DIRECTION';

  late final SharedPreferences _sharedPrefs;

  final _log = Logger('LocalStorageService');

  Future<LocalStorageService> init() async {
    _sharedPrefs = await SharedPreferences.getInstance();
    _log.finest('Initialized local storage service');

    return this;
  }

  Result<MarqueeConfigModel> fetchMarqueeConfig() {
    try {
      final blink = _sharedPrefs.getBool(_blinkKey);
      final mirror = _sharedPrefs.getBool(_mirrorKey);
      final message = _sharedPrefs.getString(_messageKey);
      final size = _sharedPrefs.getDouble(_sizeKey);
      final velocity = _sharedPrefs.getDouble(_velocityKey);
      final textColorValue = _sharedPrefs.getInt(_messageColorKey);
      final backgroundColorValue = _sharedPrefs.getInt(_backgroundColorKey);
      final scrollDirectionIndex = _sharedPrefs.getInt(_scrollDirectionKey);
      final textDirectionIndex = _sharedPrefs.getInt(_messageDirectionKey);

      if (blink == null ||
          mirror == null ||
          message == null ||
          size == null ||
          velocity == null ||
          textColorValue == null ||
          backgroundColorValue == null ||
          scrollDirectionIndex == null ||
          textDirectionIndex == null) {
        _log.warning('Failed to fetch marquee config from local storage');
        return Result.failure(Exception('Failed to fetch marquee config'));
      }

      final messageColor = Color(textColorValue);
      final backgroundColor = Color(backgroundColorValue);
      final scrollDirection = Axis.values[scrollDirectionIndex];
      final messageDirection = TextDirection.values[textDirectionIndex];

      final marqueeConfig = MarqueeConfigModel(
        blink: blink,
        mirror: mirror,
        message: message,
        size: size,
        velocity: velocity,
        messageColor: messageColor,
        backgroundColor: backgroundColor,
        scrollDirection: scrollDirection,
        messageDirection: messageDirection,
      );

      _log.finer('Fetched marquee config: $marqueeConfig from local storage');
      return Result.success(marqueeConfig);
    } on Exception catch (e) {
      _log.warning('Failed to fetch marquee config from local storage', e);
      return Result.failure(e);
    }
  }

  Future<Result<void>> saveMarqueeConfig(
    MarqueeConfigModel marqueeConfig,
  ) async {
    try {
      await _sharedPrefs.setBool(_blinkKey, marqueeConfig.blink);
      await _sharedPrefs.setBool(_mirrorKey, marqueeConfig.mirror);
      await _sharedPrefs.setString(_messageKey, marqueeConfig.message);
      await _sharedPrefs.setDouble(_sizeKey, marqueeConfig.size);
      await _sharedPrefs.setDouble(_velocityKey, marqueeConfig.velocity);
      await _sharedPrefs.setInt(
          _messageColorKey, marqueeConfig.messageColor.value);
      await _sharedPrefs.setInt(
          _backgroundColorKey, marqueeConfig.backgroundColor.value);
      await _sharedPrefs.setInt(
          _scrollDirectionKey, marqueeConfig.scrollDirection.index);
      await _sharedPrefs.setInt(
          _messageDirectionKey, marqueeConfig.messageDirection.index);

      _log.finer('Saved marquee config: $marqueeConfig to local storage');
      return const Result.success(null);
    } on Exception catch (e) {
      _log.warning('Failed to save marquee config to local storage', e);
      return Result.failure(e);
    }
  }
}
