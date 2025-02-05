import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/models/marquee/marquee_model.dart';
import '../../utils/result.dart';

class LocalStorageService {
  static const _blinkKey = 'BLINK';
  static const _mirrorKey = 'MIRROR';
  static const _textKey = 'TEXT';
  static const _textSizeKey = 'TEXT_SIZE';
  static const _velocityKey = 'VELOCITY';
  static const _textColorKey = 'TEXT_COLOR';
  static const _backgroundColorKey = 'BACKGROUND_COLOR';
  static const _scrollDirectionKey = 'SCROLL_DIRECTION';
  static const _textDirectionKey = 'TEXT_DIRECTION';

  final _log = Logger('LocalStorageService');

  Future<Result<MarqueeModel>> fetchMarquee() async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();

      final blink = sharedPreferences.getBool(_blinkKey);
      final mirror = sharedPreferences.getBool(_mirrorKey);
      final text = sharedPreferences.getString(_textKey);
      final textSize = sharedPreferences.getDouble(_textSizeKey);
      final velocity = sharedPreferences.getDouble(_velocityKey);
      final textColorValue = sharedPreferences.getInt(_textColorKey);
      final backgroundColorValue =
          sharedPreferences.getInt(_backgroundColorKey);
      final scrollDirectionIndex =
          sharedPreferences.getInt(_scrollDirectionKey);
      final textDirectionIndex = sharedPreferences.getInt(_textDirectionKey);

      if (blink == null ||
          mirror == null ||
          text == null ||
          textSize == null ||
          velocity == null ||
          textColorValue == null ||
          backgroundColorValue == null ||
          scrollDirectionIndex == null ||
          textDirectionIndex == null) {
        _log.warning('Failed to fetch marquee from local storage');
        return Result.failure(Exception('Failed to fetch marquee'));
      }

      final textColor = Color(textColorValue);
      final backgroundColor = Color(backgroundColorValue);
      final scrollDirection = Axis.values[scrollDirectionIndex];
      final textDirection = TextDirection.values[textDirectionIndex];

      final marquee = MarqueeModel(
        blink: blink,
        mirror: mirror,
        text: text,
        textSize: textSize,
        velocity: velocity,
        textColor: textColor,
        backgroundColor: backgroundColor,
        scrollDirection: scrollDirection,
        textDirection: textDirection,
      );

      _log.finer('Fetched marquee: $marquee from local storage');
      return Result.success(marquee);
    } on Exception catch (e) {
      _log.warning('Failed to fetch marquee from local storage', e);
      return Result.failure(e);
    }
  }

  Future<Result<void>> saveMarquee(MarqueeModel marquee) async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();

      await sharedPreferences.setBool(_blinkKey, marquee.blink);
      await sharedPreferences.setBool(_mirrorKey, marquee.mirror);
      await sharedPreferences.setString(_textKey, marquee.text);
      await sharedPreferences.setDouble(_textSizeKey, marquee.textSize);
      await sharedPreferences.setDouble(_velocityKey, marquee.velocity);
      await sharedPreferences.setInt(_textColorKey, marquee.textColor.value);
      await sharedPreferences.setInt(
          _backgroundColorKey, marquee.backgroundColor.value);
      await sharedPreferences.setInt(
          _scrollDirectionKey, marquee.scrollDirection.index);
      await sharedPreferences.setInt(
          _textDirectionKey, marquee.textDirection.index);

      _log.finer('Saved marquee: $marquee to local storage');
      return const Result.success(null);
    } on Exception catch (e) {
      _log.warning('Failed to save marquee to local storage', e);
      return Result.failure(e);
    }
  }
}
