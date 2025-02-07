import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shout_board/ui/settings/view_model/settings_viewmodel.dart';

import '../ui/home/view_model/home_viewmodel.dart';
import '../ui/home/widgets/home_screen.dart';
import '../ui/language/widgets/language_screen.dart';
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
        builder: (context, _) => HomeScreen(
          viewModel: HomeViewModel(
            context: context,
            marqueeConfigRepository: context.read(),
          ),
        ),
        routes: [
          GoRoute(
            path: Routes.marquee,
            builder: (context, _) => MarqueeScreen(
              viewModel: MarqueeViewModel(
                context: context,
                marqueeConfigRepository: context.read(),
              ),
            ),
          ),
          GoRoute(
            path: Routes.settings,
            builder: (context, _) => SettingsScreen(
              viewModel: SettingsViewModel(appConfigRepository: context.read()),
            ),
            routes: [
              GoRoute(
                path: Routes.language,
                builder: (context, _) =>
                    LanguageScreen(viewModel: context.read()),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
