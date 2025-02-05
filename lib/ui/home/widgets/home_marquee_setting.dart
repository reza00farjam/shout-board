import 'package:flutter/material.dart';

import '../../../domain/models/marquee/marquee_model.dart';
import '../view_model/home_viewmodel.dart';
import 'home_color_picker_list_tile.dart';

class HomeMarqueeSetting extends StatefulWidget {
  final HomeViewModel viewModel;

  const HomeMarqueeSetting({
    super.key,
    required this.viewModel,
  });

  @override
  State<HomeMarqueeSetting> createState() => _HomeMarqueeSettingState();
}

class _HomeMarqueeSettingState extends State<HomeMarqueeSetting> {
  late final _textController =
      TextEditingController(text: widget.viewModel.marquee!.text);

  @override
  Widget build(BuildContext context) {
    const gap = SizedBox.square(dimension: 16);

    return SingleChildScrollView(
      padding: const EdgeInsets.only(
        top: 16,
        bottom: 16 + 64,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final sliderWidth = constraints.maxWidth - 120;

          return ListenableBuilder(
            listenable: widget.viewModel,
            builder: (context, _) {
              final marquee = widget.viewModel.marquee!;

              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      controller: _textController,
                      decoration: const InputDecoration(label: Text('Text')),
                      onTapOutside: (_) => FocusScope.of(context).unfocus(),
                      onChanged: (text) => widget.viewModel.updateMarquee(
                        marquee.copyWith(text: text),
                      ),
                    ),
                  ),
                  gap,
                  ListTile(
                    title: const Text('Size'),
                    trailing: SizedBox(
                      width: sliderWidth,
                      child: Slider(
                        value: marquee.textSize,
                        min: MarqueeModel.textSizeMinValue,
                        max: MarqueeModel.textSizeMaxValue,
                        onChanged: (size) => widget.viewModel.updateMarquee(
                          marquee.copyWith(textSize: size),
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    title: const Text('Velocity'),
                    trailing: SizedBox(
                      width: sliderWidth,
                      child: Slider(
                        value: marquee.velocity,
                        min: MarqueeModel.velocityMinValue,
                        max: MarqueeModel.velocityMaxValue,
                        onChanged: (velocity) => widget.viewModel.updateMarquee(
                          marquee.copyWith(velocity: velocity),
                        ),
                      ),
                    ),
                  ),
                  SwitchListTile(
                    title: const Text('Left to Right'),
                    value: marquee.textDirection == TextDirection.ltr,
                    onChanged: (leftToRight) => widget.viewModel.updateMarquee(
                      marquee.copyWith(
                        textDirection:
                            leftToRight ? TextDirection.ltr : TextDirection.rtl,
                      ),
                    ),
                  ),
                  SwitchListTile(
                    title: const Text('Horizontal'),
                    value: marquee.scrollDirection == Axis.horizontal,
                    onChanged: (isHorizontal) => widget.viewModel.updateMarquee(
                      marquee.copyWith(
                        scrollDirection:
                            isHorizontal ? Axis.horizontal : Axis.vertical,
                      ),
                    ),
                  ),
                  SwitchListTile(
                    value: marquee.blink,
                    title: const Text('Blink'),
                    onChanged: (blink) => widget.viewModel.updateMarquee(
                      marquee.copyWith(blink: blink),
                    ),
                  ),
                  SwitchListTile(
                    value: marquee.mirror,
                    title: const Text('Mirror'),
                    onChanged: (mirror) => widget.viewModel.updateMarquee(
                      marquee.copyWith(mirror: mirror),
                    ),
                  ),
                  HomeColorPickerListTile(
                    value: marquee.textColor,
                    title: const Text('Text Color'),
                    onChanged: (color) => widget.viewModel.updateMarquee(
                      marquee.copyWith(textColor: color),
                    ),
                  ),
                  HomeColorPickerListTile(
                    value: marquee.backgroundColor,
                    title: const Text('Background Color'),
                    onChanged: (color) => widget.viewModel.updateMarquee(
                      marquee.copyWith(backgroundColor: color),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
