import 'package:flutter/material.dart';

import '../../../domain/models/marquee_config/marquee_config_model.dart';
import '../../core/localization/localization.dart';
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
                      decoration: InputDecoration(
                        label: Text(AppLocalization.of(context).message),
                      ),
                      onTapOutside: (_) => FocusScope.of(context).unfocus(),
                      onChanged: (message) =>
                          widget.viewModel.updateMarqueeConfig(
                        marqueeConfig.copyWith(message: message),
                      ),
                    ),
                  ),
                  gap,
                  ListTile(
                    title: Text(AppLocalization.of(context).size),
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
                    title: Text(AppLocalization.of(context).velocity),
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
                    title: Text(AppLocalization.of(context).leftToRight),
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
                    title: Text(AppLocalization.of(context).horizontal),
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
                    title: Text(AppLocalization.of(context).blink),
                    onChanged: (blink) => widget.viewModel.updateMarqueeConfig(
                      marqueeConfig.copyWith(blink: blink),
                    ),
                  ),
                  SwitchListTile(
                    value: marqueeConfig.mirror,
                    title: Text(AppLocalization.of(context).mirror),
                    onChanged: (mirror) => widget.viewModel.updateMarqueeConfig(
                      marqueeConfig.copyWith(mirror: mirror),
                    ),
                  ),
                  HomeColorPickerListTile(
                    value: marqueeConfig.messageColor,
                    title: Text(AppLocalization.of(context).messageColor),
                    onChanged: (color) => widget.viewModel.updateMarqueeConfig(
                      marqueeConfig.copyWith(messageColor: color),
                    ),
                  ),
                  HomeColorPickerListTile(
                    value: marqueeConfig.backgroundColor,
                    title: Text(AppLocalization.of(context).backgroundColor),
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
