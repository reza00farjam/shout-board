import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:go_router/go_router.dart';

class HomeColorPickerListTile extends StatelessWidget {
  final Color value;
  final Widget title;
  final void Function(Color) onChanged;

  const HomeColorPickerListTile({
    super.key,
    required this.value,
    required this.title,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: title,
      trailing: Container(
        width: 48,
        height: 40,
        margin: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          color: value,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      onTap: () => showDialog(
        context: context,
        builder: (context) {
          const gapSize = 8.0;
          const paddingSize = 16.0;

          return AlertDialog(
            title: title,
            scrollable: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: paddingSize),
            titlePadding: const EdgeInsets.only(
              top: paddingSize,
              left: paddingSize,
              right: paddingSize,
              bottom: gapSize,
            ),
            actionsPadding: const EdgeInsets.only(
              top: gapSize,
              left: paddingSize,
              right: paddingSize,
              bottom: paddingSize,
            ),
            content: ColorPicker(
              hexInputBar: true,
              pickerColor: value,
              onColorChanged: onChanged,
              paletteType: PaletteType.hsl,
              pickerAreaHeightPercent: 0.8,
              pickerAreaBorderRadius: BorderRadius.circular(4),
            ),
            actions: [
              ElevatedButton(
                onPressed: context.pop,
                child: const Text('Got it'),
              ),
            ],
          );
        },
      ),
    );
  }
}
