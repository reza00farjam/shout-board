import 'dart:async';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import '../../../data/repositories/marquee_repository.dart';
import '../../../domain/models/marquee/marquee_model.dart';
import '../../../utils/command.dart';
import '../../../utils/result.dart';

class HomeViewModel extends ChangeNotifier {
  final MarqueeRepository _marqueeRepository;

  HomeViewModel({
    required MarqueeRepository marqueeRepository,
  }) : _marqueeRepository = marqueeRepository {
    loadMarquee = Command0(_loadMarquee)..execute();
  }

  late Command0 loadMarquee;

  final _log = Logger('HomeViewModel');

  Timer? _updateMarqueeDebounce;
  MarqueeModel? _marquee;

  MarqueeModel? get marquee => _marquee;

  Future<Result> _loadMarquee() async {
    try {
      final result = await _marqueeRepository.fetchMarquee();

      switch (result) {
        case Success():
          _marquee = result.value;
          _log.fine('Loaded marquee');
        case Failure():
          _marquee = MarqueeModel.defaultInstance;
          _log.warning('Failed to load marquee', result.error);
      }

      return result;
    } finally {
      notifyListeners();
    }
  }

  void updateMarquee(MarqueeModel newMarquee) {
    _marquee = newMarquee;
    notifyListeners();

    _updateMarqueeDebounce?.cancel();
    _updateMarqueeDebounce = Timer(
      const Duration(milliseconds: 100),
      () async {
        final result = await _marqueeRepository.saveMarquee(newMarquee);

        switch (result) {
          case Success():
            _log.fine('Saved marquee');
          case Failure():
            _log.warning('Failed to save marquee', result.error);
        }
      },
    );
  }
}
