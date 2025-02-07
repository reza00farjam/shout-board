import 'package:flutter/widgets.dart';

extension AppLocale on Locale {
  String get title => switch (languageCode) {
        'fa' => 'Persian',
        _ => 'English',
      };

  String get titleNative => switch (languageCode) {
        'fa' => 'فارسی',
        _ => 'English',
      };
}
