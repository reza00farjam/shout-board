import 'dart:async';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import '../../../data/repositories/marquee_config_repository.dart';
import '../../../domain/models/marquee/marquee_config_model.dart';
import '../../../utils/command.dart';
import '../../../utils/result.dart';

class MarqueeViewModel extends ChangeNotifier {
  final MarqueeConfigRepository _marqueeConfigRepository;

  MarqueeViewModel({
    required MarqueeConfigRepository marqueeConfigRepository,
  }) : _marqueeConfigRepository = marqueeConfigRepository {
    loadMarqueeConfig = Command0(_loadMarqueeConfig)..execute();
  }

  late Command0 loadMarqueeConfig;

  final _log = Logger('MarqueeViewModel');

  MarqueeConfigModel? _marqueeConfig;

  MarqueeConfigModel? get marqueeConfig => _marqueeConfig;

  Future<Result> _loadMarqueeConfig() async {
    try {
      final result = await _marqueeConfigRepository.fetchMarqueeConfig();

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
