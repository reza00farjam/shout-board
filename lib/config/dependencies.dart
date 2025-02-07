import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../data/repositories/app_config_repository.dart';
import '../data/repositories/marquee_config_repository.dart';
import '../data/services/local_storage_service.dart';
import '../ui/language/view_model/language_viewmodel.dart';

List<SingleChildWidget> get providers {
  return [
    // Services
    FutureProvider(
      lazy: false,
      initialData: null,
      create: (_) => LocalStorageService().init(),
    ),

    // Repositories
    Provider(
      create: (context) => AppConfigRepository(
        localStorageService: context.read(),
      ),
    ),
    Provider(
      create: (context) => MarqueeConfigRepository(
        localStorageService: context.read(),
      ),
    ),

    // ViewModels
    ChangeNotifierProvider(
      create: (context) => LanguageViewModel(
        appConfigRepository: context.read(),
      ),
    ),
  ];
}
