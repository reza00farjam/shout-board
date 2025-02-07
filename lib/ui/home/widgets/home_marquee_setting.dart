import 'package:flutter/material.dart';

import '../../../domain/models/marquee/marquee_config_model.dart';
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
  late final _messageController =
      TextEditingController(text: widget.viewModel.marqueeConfig.message);

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
              final marqueeConfig = widget.viewModel.marqueeConfig;

              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      controller: _messageController,
                      decoration: const InputDecoration(label: Text('Message')),
                      onTapOutside: (_) => FocusScope.of(context).unfocus(),
                      onChanged: (message) =>
                          widget.viewModel.updateMarqueeConfig(
                        marqueeConfig.copyWith(message: message),
                      ),
                    ),
                  ),
                  gap,
                  ListTile(
                    title: const Text('Size'),
                    trailing: SizedBox(
                      width: sliderWidth,
                      child: Slider(
                        value: marqueeConfig.size,
                        min: MarqueeConfigModel.sizeMinValue,
                        max: MarqueeConfigModel.sizeMaxValue,
                        onChanged: (size) =>
                            widget.viewModel.updateMarqueeConfig(
                          marqueeConfig.copyWith(size: size),
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    title: const Text('Velocity'),
                    trailing: SizedBox(
                      width: sliderWidth,
                      child: Slider(
                        value: marqueeConfig.velocity,
                        min: MarqueeConfigModel.velocityMinValue,
                        max: MarqueeConfigModel.velocityMaxValue,
                        onChanged: (velocity) =>
                            widget.viewModel.updateMarqueeConfig(
                          marqueeConfig.copyWith(velocity: velocity),
                        ),
                      ),
                    ),
                  ),
                  SwitchListTile(
                    title: const Text('Left to Right'),
                    value: marqueeConfig.messageDirection == TextDirection.ltr,
                    onChanged: (leftToRight) =>
                        widget.viewModel.updateMarqueeConfig(
                      marqueeConfig.copyWith(
                        messageDirection:
                            leftToRight ? TextDirection.ltr : TextDirection.rtl,
                      ),
                    ),
                  ),
                  SwitchListTile(
                    title: const Text('Horizontal'),
                    value: marqueeConfig.scrollDirection == Axis.horizontal,
                    onChanged: (isHorizontal) =>
                        widget.viewModel.updateMarqueeConfig(
                      marqueeConfig.copyWith(
                        scrollDirection:
                            isHorizontal ? Axis.horizontal : Axis.vertical,
                      ),
                    ),
                  ),
                  SwitchListTile(
                    value: marqueeConfig.blink,
                    title: const Text('Blink'),
                    onChanged: (blink) => widget.viewModel.updateMarqueeConfig(
                      marqueeConfig.copyWith(blink: blink),
                    ),
                  ),
                  SwitchListTile(
                    value: marqueeConfig.mirror,
                    title: const Text('Mirror'),
                    onChanged: (mirror) => widget.viewModel.updateMarqueeConfig(
                      marqueeConfig.copyWith(mirror: mirror),
                    ),
                  ),
                  HomeColorPickerListTile(
                    value: marqueeConfig.messageColor,
                    title: const Text('Message Color'),
                    onChanged: (color) => widget.viewModel.updateMarqueeConfig(
                      marqueeConfig.copyWith(messageColor: color),
                    ),
                  ),
                  HomeColorPickerListTile(
                    value: marqueeConfig.backgroundColor,
                    title: const Text('Background Color'),
                    onChanged: (color) => widget.viewModel.updateMarqueeConfig(
                      marqueeConfig.copyWith(backgroundColor: color),
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
