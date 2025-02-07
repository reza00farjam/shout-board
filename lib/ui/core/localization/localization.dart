import 'package:flutter/widgets.dart';

class AppLocalization {
  final Locale locale;

  AppLocalization(this.locale);

  static const supportedLocales = [
    Locale('en'), // English
    Locale('fa'), // Persian
  ];

  static AppLocalization of(BuildContext context) {
    return Localizations.of(context, AppLocalization)!;
  }

  static Locale localeResolutionCallback(
    Locale? locale,
    Iterable<Locale> supportedLocales,
  ) {
    return Locale(
      switch (locale?.languageCode.split('_').first) {
        'fa' => 'fa',
        _ => 'en',
      },
    );
  }

  T when<T>({
    required T Function() en,
    required T Function() fa,
  }) {
    return switch (locale.languageCode) {
      'fa' => fa(),
      _ => en(),
    };
  }

  static const _titleKey = 'title';
  static const _messageKey = 'message';
  static const _sizeKey = 'size';
  static const _velocityKey = 'velocity';
  static const _leftToRightKey = 'leftToRight';
  static const _horizontalKey = 'horizontal';
  static const _blinkKey = 'blink';
  static const _mirrorKey = 'mirror';
  static const _messageColorKey = 'messageColor';
  static const _backgroundColorKey = 'backgroundColor';
  static const _playKey = 'play';
  static const _pauseKey = 'pause';
  static const _settingsKey = 'settings';
  static const _previewKey = 'preview';
  static const _languageKey = 'language';
  static const _systemDefaultKey = 'systemDefault';

  static const _localizedValues = <String, Map<String, String>>{
    'en': {
      _titleKey: 'ShoutBoard',
      _messageKey: 'Message',
      _sizeKey: 'Size',
      _velocityKey: 'Velocity',
      _leftToRightKey: 'Left to Right',
      _horizontalKey: 'Horizontal',
      _blinkKey: 'Blink',
      _mirrorKey: 'Mirror',
      _messageColorKey: 'Message Color',
      _backgroundColorKey: 'Background Color',
      _playKey: 'Play',
      _pauseKey: 'Pause',
      _settingsKey: 'Settings',
      _previewKey: 'PREVIEW',
      _languageKey: 'Language',
      _systemDefaultKey: 'System Default',
    },
    'fa': {
      _titleKey: 'دادبورد',
      _messageKey: 'متن',
      _sizeKey: 'اندازه',
      _velocityKey: 'سرعت',
      _leftToRightKey: 'از چپ به راست',
      _horizontalKey: 'افقی',
      _blinkKey: 'چشمک‌زن',
      _mirrorKey: 'آینه',
      _messageColorKey: 'رنگ متن',
      _backgroundColorKey: 'رنگ پس‌زمینه',
      _playKey: 'پخش',
      _pauseKey: 'توقف',
      _settingsKey: 'تنظیمات',
      _previewKey: 'پیش‌نمایش',
      _languageKey: 'زبان',
      _systemDefaultKey: 'پیش‌فرض سیستم',
    },
  };

  String _get(String key) =>
      _localizedValues[locale.languageCode]?[key] ??
      _localizedValues['en']![key]!;

  String get title => _get(_titleKey);
  String get message => _get(_messageKey);
  String get size => _get(_sizeKey);
  String get velocity => _get(_velocityKey);
  String get leftToRight => _get(_leftToRightKey);
  String get horizontal => _get(_horizontalKey);
  String get blink => _get(_blinkKey);
  String get mirror => _get(_mirrorKey);
  String get messageColor => _get(_messageColorKey);
  String get backgroundColor => _get(_backgroundColorKey);
  String get play => _get(_playKey);
  String get pause => _get(_pauseKey);
  String get settings => _get(_settingsKey);
  String get preview => _get(_previewKey);
  String get language => _get(_languageKey);
  String get systemDefault => _get(_systemDefaultKey);
}
