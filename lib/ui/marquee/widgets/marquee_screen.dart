import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../core/ui/marquee_text.dart';
import '../view_model/marquee_viewmodel.dart';

class MarqueeScreen extends StatefulWidget {
  final MarqueeViewModel viewModel;

  const MarqueeScreen({
    super.key,
    required this.viewModel,
  });

  @override
  State<MarqueeScreen> createState() => _MarqueeScreenState();
}

class _MarqueeScreenState extends State<MarqueeScreen> {
  @override
  void initState() {
    super.initState();

    // Hide the system overlays (status bar, navigation bar, etc.)
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [],
    );

    // Lock the screen orientation to landscape
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ],
    );
  }

  @override
  dispose() {
    // Reset the system overlays
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );

    // Reset the screen orientation to all
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Opacity(
        opacity: 0.3,
        child: FloatingActionButton.extended(
          onPressed: context.pop,
          label: const Text('Pause'),
          icon: const Icon(Icons.pause_rounded),
        ),
      ),
      body: MarqueeText(marqueeConfig: widget.viewModel.marqueeConfig),
    );
  }
}
