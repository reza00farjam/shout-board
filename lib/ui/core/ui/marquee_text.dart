import 'dart:async';

import 'package:flutter/material.dart';
import 'package:marqueer/marqueer.dart';

import '../../../domain/models/marquee/marquee_config_model.dart';

class MarqueeText extends StatefulWidget {
  final MarqueeConfigModel marqueeConfig;

  const MarqueeText({
    super.key,
    required this.marqueeConfig,
  });

  @override
  State<MarqueeText> createState() => _MarqueeTextState();
}

class _MarqueeTextState extends State<MarqueeText> {
  late ValueKey _marqueerKey = ValueKey(widget.marqueeConfig.velocity);

  Timer? _timer;
  bool _isMarqueeVisible = true;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(
      const Duration(milliseconds: 50),
      (timer) {
        if (mounted) {
          setState(
            () => _isMarqueeVisible = !_isMarqueeVisible,
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // If the velocity changes, the Marqueer widget needs to be rebuilt completely.
    if (_marqueerKey.value != widget.marqueeConfig.velocity) {
      setState(() => _marqueerKey = ValueKey(widget.marqueeConfig.velocity));
    }

    return LayoutBuilder(
      builder: (_, constraints) {
        final fontSize = widget.marqueeConfig.size * constraints.maxHeight;

        return RotatedBox(
          quarterTurns:
              widget.marqueeConfig.scrollDirection == Axis.horizontal ? 0 : -1,
          child: Container(
            color: widget.marqueeConfig.backgroundColor,
            child: Center(
              child: Transform.flip(
                flipX: widget.marqueeConfig.mirror,
                child: Marqueer(
                  key: _marqueerKey,
                  interaction: false,
                  pps: widget.marqueeConfig.velocity * 1000,
                  separatorBuilder: (_, __) =>
                      SizedBox.square(dimension: 1.5 * fontSize),
                  direction:
                      widget.marqueeConfig.scrollDirection == Axis.horizontal
                          ? widget.marqueeConfig.messageDirection ==
                                  TextDirection.ltr
                              ? MarqueerDirection.rtl
                              : MarqueerDirection.ltr
                          : MarqueerDirection.ttb,
                  child: Text(
                    widget.marqueeConfig.scrollDirection == Axis.horizontal
                        ? widget.marqueeConfig.message
                        : widget.marqueeConfig.message.split('').join('\n'),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      height: 1,
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold,
                      color: widget.marqueeConfig.messageColor.withOpacity(
                        widget.marqueeConfig.blink
                            ? _isMarqueeVisible
                                ? 1
                                : 0
                            : 1,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
