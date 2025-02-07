import 'dart:async';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import '../../../data/repositories/marquee_config_repository.dart';
import '../../../domain/models/marquee/marquee_config_model.dart';
import '../../../utils/result.dart';

class HomeViewModel extends ChangeNotifier {
  final MarqueeConfigRepository _marqueeConfigRepository;

  HomeViewModel({
    required MarqueeConfigRepository marqueeConfigRepository,
  }) : _marqueeConfigRepository = marqueeConfigRepository {
    loadMarqueeConfig();
  }

  final _log = Logger('HomeViewModel');

  Timer? _updateMarqueeConfigDebounce;

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

  void updateMarqueeConfig(MarqueeConfigModel newMarqueeConfig) {
    _marqueeConfig = newMarqueeConfig;
    notifyListeners();

    _updateMarqueeConfigDebounce?.cancel();
    _updateMarqueeConfigDebounce = Timer(
      const Duration(milliseconds: 100),
      () async {
        final result =
            await _marqueeConfigRepository.saveMarqueeConfig(newMarqueeConfig);

        switch (result) {
          case Success():
            _log.fine('Saved marquee config');
          case Failure():
            _log.warning('Failed to save marquee config', result.error);
        }
      },
    );
  }
}
