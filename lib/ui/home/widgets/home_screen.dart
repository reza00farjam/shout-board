import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../view_model/home_viewmodel.dart';
import '../../core/ui/marquee_text.dart';
import '../../../routing/routes.dart';
import 'home_marquee_setting.dart';

class HomeScreen extends StatelessWidget {
  final HomeViewModel viewModel;

  const HomeScreen({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel.loadMarquee,
      builder: (_, __) {
        if (viewModel.loadMarquee.running) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final marquee = ListenableBuilder(
          listenable: viewModel,
          builder: (_, __) => MarqueeText(marquee: viewModel.marquee!),
        );

        final setting = HomeMarqueeSetting(viewModel: viewModel);

        return Scaffold(
          resizeToAvoidBottomInset: false,
          floatingActionButton: FloatingActionButton.extended(
            label: const Text('Play'),
            icon: const Icon(Icons.play_arrow_rounded),
            onPressed: () => context.push(Routes.marquee),
          ),
          body: SafeArea(
            child: OrientationBuilder(
              builder: (context, orientation) {
                if (orientation == Orientation.landscape) {
                  return SafeArea(
                    child: Row(
                      children: [
                        Expanded(flex: 3, child: marquee),
                        Expanded(flex: 2, child: setting),
                      ],
                    ),
                  );
                }

                return Column(
                  children: [
                    Expanded(flex: 2, child: marquee),
                    Expanded(flex: 3, child: setting),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
