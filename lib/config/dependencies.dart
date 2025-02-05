import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../data/repositories/marquee_repository.dart';
import '../data/services/local_storage_service.dart';

List<SingleChildWidget> get providers {
  return [
    // Services
    Provider(
      create: (_) => LocalStorageService(),
    ),

    // Repositories
    Provider(
      create: (context) => MarqueeRepository(
        localStorageService: context.read(),
      ),
    ),
  ];
}
