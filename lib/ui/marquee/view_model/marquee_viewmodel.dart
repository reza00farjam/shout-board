import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import '../../../data/repositories/marquee_config_repository.dart';
import '../../../domain/models/marquee/marquee_config_model.dart';
import '../../../utils/result.dart';

class MarqueeViewModel extends ChangeNotifier {
  final MarqueeConfigRepository _marqueeConfigRepository;

  MarqueeViewModel({
    required MarqueeConfigRepository marqueeConfigRepository,
  }) : _marqueeConfigRepository = marqueeConfigRepository {
    loadMarqueeConfig();
  }

  final _log = Logger('MarqueeViewModel');

  late MarqueeConfigModel _marqueeConfig;

  MarqueeConfigModel get marqueeConfig => _marqueeConfig;

  Result loadMarqueeConfig() {
    try {
      final result = _marqueeConfigRepository.fetchMarqueeConfig();

      switch (result) {
        case Success():
          _marqueeConfig = result.value;
          _log.fine('Loaded marquee config');
        case Failure():
          _marqueeConfig = MarqueeConfigModel.defaultInstance;
          _log.warning('Failed to load marquee config', result.error);
      }

      return result;
    } finally {
      notifyListeners();
    }
  }
}
