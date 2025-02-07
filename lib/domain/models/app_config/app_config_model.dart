import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_config_model.freezed.dart';

@freezed
class AppConfigModel with _$AppConfigModel {
  const factory AppConfigModel({
    Locale? locale,
  }) = _AppConfigModel;

  static const defaultInstance = AppConfigModel();
}
