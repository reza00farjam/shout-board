import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'marquee_model.freezed.dart';

@freezed
class MarqueeModel with _$MarqueeModel {
  @Assert(
    'textSize >= MarqueeModel.textSizeMinValue && textSize <= MarqueeModel.textSizeMaxValue',
    'textSize must be in range [${MarqueeModel.textSizeMinValue}, ${MarqueeModel.textSizeMaxValue}]',
  )
  @Assert(
    'velocity >= MarqueeModel.velocityMinValue && velocity <= MarqueeModel.velocityMaxValue',
    'velocity must be in range [${MarqueeModel.velocityMinValue}, ${MarqueeModel.velocityMaxValue}]',
  )
  const factory MarqueeModel({
    required bool blink,
    required bool mirror,
    required String text,
    required double textSize,
    required double velocity,
    required Color textColor,
    required Color backgroundColor,
    required Axis scrollDirection,
    required TextDirection textDirection,
  }) = _MarqueeModel;

  static const textSizeMinValue = 0.1;
  static const textSizeMaxValue = 1.0;

  static const velocityMinValue = 0.01;
  static const velocityMaxValue = 1.0;

  static const defaultInstance = MarqueeModel(
    blink: false,
    mirror: false,
    text: 'PREVIEW',
    textColor: Colors.white,
    textSize: textSizeMaxValue,
    backgroundColor: Colors.black,
    scrollDirection: Axis.horizontal,
    textDirection: TextDirection.ltr,
    velocity: 0.2 * velocityMaxValue,
  );
}
