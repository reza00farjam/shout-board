import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../data/repositories/marquee_config_repository.dart';
import '../data/services/local_storage_service.dart';

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
      create: (context) => MarqueeConfigRepository(
        localStorageService: context.read(),
      ),
    ),
  ];
}
