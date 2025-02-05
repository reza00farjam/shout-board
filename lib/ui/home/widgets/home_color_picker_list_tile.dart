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
        builder: (context) => AlertDialog(
          scrollable: true,
          title: title,
          content: ColorPicker(
            hexInputBar: true,
            pickerColor: value,
            labelTypes: const [],
            paletteType: PaletteType.hsl,
            onColorChanged: onChanged,
            pickerAreaBorderRadius: BorderRadius.circular(4),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: context.pop,
              child: const Text('Got it'),
            ),
          ],
        ),
      ),
    );
  }
}
