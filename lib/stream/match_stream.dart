import 'dart:developer';

import 'package:rxdart/rxdart.dart';
import 'package:testadmob/stream/modal.dart';
import 'package:testadmob/stream/service.dart';

class LiveStream {
  static final LiveStream _liveStream = LiveStream.init();

  factory LiveStream() {
    return _liveStream;
  }
  LiveStream.init();
  MatchController _matchController = MatchController();

  final _MatchStreamController = PublishSubject<List<Example>>();

  Stream get MatchStream => _MatchStreamController.stream;
  Example? example;

  Future<List<Example>> getMatches() async {
    try {
      List<Example>? feturedModelResponse = await _matchController.getMatches() ?? [];
      log('testsdhsad feturedModelResponse: ${feturedModelResponse.length}');
      _MatchStreamController.add(feturedModelResponse);
      return feturedModelResponse;
    } catch (e) {
      _MatchStreamController.addError(e.toString());
    }
    return [];
  }
}
