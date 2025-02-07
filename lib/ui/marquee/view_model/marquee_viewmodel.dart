import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import '../../../data/repositories/marquee_config_repository.dart';
import '../../../domain/models/marquee_config/marquee_config_model.dart';
import '../../../utils/result.dart';

class MarqueeViewModel extends ChangeNotifier {
  final MarqueeConfigRepository _marqueeConfigRepository;

  MarqueeViewModel({
    required BuildContext context,
    required MarqueeConfigRepository marqueeConfigRepository,
  }) : _marqueeConfigRepository = marqueeConfigRepository {
    loadMarqueeConfig(context);
  }

  final _log = Logger('MarqueeViewModel');

  late MarqueeConfigModel _marqueeConfig;

  MarqueeConfigModel get marqueeConfig => _marqueeConfig;

  Result loadMarqueeConfig(BuildContext context) {
    try {
      final result = _marqueeConfigRepository.fetchMarqueeConfig();

      switch (result) {
        case Success():
          _marqueeConfig = result.value;
          _log.fine('Loaded marquee config');
        case Failure():
          _marqueeConfig = MarqueeConfigModel.defaultInstance(context);
          _log.warning('Failed to load marquee config', result.error);
      }

      return result;
    } finally {
      notifyListeners();
    }
  }
}
