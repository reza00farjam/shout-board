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

  // We are not interested in this function's execution state for updating the UI.
  // Additionally, this might be called while a previous call hasn't ended, so we don't want
  // to block new calls. Therefore, we don't need to wrap it in a `Command`.
  Future<void> updateMarquee(MarqueeModel newMarquee) async {
    _marquee = newMarquee;
    notifyListeners();

    final result = await _marqueeRepository.saveMarquee(newMarquee);

    switch (result) {
      case Success():
        _log.fine('Saved marquee');
      case Failure():
        _log.warning('Failed to save marquee', result.error);
    }
  }
}
