import 'dart:async';

import 'package:flutter/material.dart';
import 'package:marqueer/marqueer.dart';

import '../../../domain/models/marquee/marquee_model.dart';

class MarqueeText extends StatefulWidget {
  final MarqueeModel marquee;

  const MarqueeText({
    super.key,
    required this.marquee,
  });

  @override
  State<MarqueeText> createState() => _MarqueeTextState();
}

class _MarqueeTextState extends State<MarqueeText> {
  late ValueKey _marqueeKey = ValueKey(widget.marquee.velocity);

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
    if (_marqueeKey.value != widget.marquee.velocity) {
      setState(() => _marqueeKey = ValueKey(widget.marquee.velocity));
    }

    return LayoutBuilder(
      builder: (_, constraints) {
        final fontSize = widget.marquee.textSize * constraints.maxHeight;

        return RotatedBox(
          quarterTurns:
              widget.marquee.scrollDirection == Axis.horizontal ? 0 : -1,
          child: Container(
            color: widget.marquee.backgroundColor,
            child: Center(
              child: Transform.flip(
                flipX: widget.marquee.mirror,
                child: Marqueer(
                  key: _marqueeKey,
                  interaction: false,
                  pps: widget.marquee.velocity * 1000,
                  separatorBuilder: (_, __) =>
                      SizedBox.square(dimension: 1.5 * fontSize),
                  direction: widget.marquee.scrollDirection == Axis.horizontal
                      ? widget.marquee.textDirection == TextDirection.ltr
                          ? MarqueerDirection.rtl
                          : MarqueerDirection.ltr
                      : MarqueerDirection.ttb,
                  child: Text(
                    widget.marquee.scrollDirection == Axis.horizontal
                        ? widget.marquee.text
                        : widget.marquee.text.split('').join('\n'),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      height: 1,
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold,
                      color: widget.marquee.textColor.withOpacity(
                        widget.marquee.blink
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
