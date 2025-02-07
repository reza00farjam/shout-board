import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../ui/core/localization/localization.dart';

part 'marquee_config_model.freezed.dart';

@freezed
class MarqueeConfigModel with _$MarqueeConfigModel {
  @Assert(
    'size >= MarqueeConfigModel.sizeMinValue && size <= MarqueeConfigModel.sizeMaxValue',
    'size must be in range [${MarqueeConfigModel.sizeMinValue}, ${MarqueeConfigModel.sizeMaxValue}]',
  )
  @Assert(
    'velocity >= MarqueeConfigModel.velocityMinValue && velocity <= MarqueeConfigModel.velocityMaxValue',
    'velocity must be in range [${MarqueeConfigModel.velocityMinValue}, ${MarqueeConfigModel.velocityMaxValue}]',
  )
  const factory MarqueeConfigModel({
    required bool blink,
    required bool mirror,
    required String message,
    required double size,
    required double velocity,
    required Color messageColor,
    required Color backgroundColor,
    required Axis scrollDirection,
    required TextDirection messageDirection,
  }) = _MarqueeConfigModel;

  static const sizeMinValue = 0.1;
  static const sizeMaxValue = 1.0;

  static const velocityMinValue = 0.01;
  static const velocityMaxValue = 1.0;

  static MarqueeConfigModel defaultInstance(BuildContext context) {
    return MarqueeConfigModel(
      blink: false,
      mirror: false,
      size: sizeMaxValue,
      messageColor: Colors.white,
      backgroundColor: Colors.black,
      velocity: 0.2 * velocityMaxValue,
      scrollDirection: Axis.horizontal,
      messageDirection: TextDirection.ltr,
      message: AppLocalization.of(context).preview,
    );
  }
}
