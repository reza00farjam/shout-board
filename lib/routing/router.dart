import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../ui/home/view_model/home_viewmodel.dart';
import '../ui/home/widgets/home_screen.dart';
import '../ui/marquee/view_model/marquee_viewmodel.dart';
import '../ui/marquee/widgets/marquee_screen.dart';
import '../ui/settings/widgets/settings_screen.dart';
import 'routes.dart';

/// `router` as a function is preferred over being top-level variable because it
/// allows for greater flexibility in the future. For example, if there is a need
/// to pass a repository as refreshListenable, it can be easily accommodated
/// by modifying the function parameters.
GoRouter router() {
  return GoRouter(
    initialLocation: Routes.home,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: Routes.home,
        builder: (context, __) => HomeScreen(
          viewModel: HomeViewModel(marqueeRepository: context.read()),
        ),
        routes: [
          GoRoute(
            path: Routes.marquee,
            builder: (context, _) => MarqueeScreen(
              viewModel: MarqueeViewModel(marqueeRepository: context.read()),
            ),
          ),
          GoRoute(
            path: Routes.settings,
            builder: (_, __) => const SettingsScreen(),
          ),
        ],
      ),
    ],
  );
}
