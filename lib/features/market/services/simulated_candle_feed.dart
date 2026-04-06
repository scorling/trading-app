import 'dart:async';
import 'dart:math';

import '../models/candle.dart';

class SimulatedCandleFeed {
  SimulatedCandleFeed(this.seedPrice);

  final double seedPrice;
  final _rnd = Random();

  List<Candle> bootstrap({int count = 60}) {
    var price = seedPrice;
    final now = DateTime.now();
    return List.generate(count, (i) {
      final open = price;
      final drift = 1 + (_rnd.nextDouble() - 0.5) * 0.002;
      final close = open * drift;
      final high = max(open, close) * (1 + _rnd.nextDouble() * 0.0015);
      final low = min(open, close) * (1 - _rnd.nextDouble() * 0.0015);
      price = close;
      return Candle(
        time: now.subtract(Duration(minutes: count - i)),
        open: open,
        high: high,
        low: low,
        close: close,
      );
    });
  }

  Stream<Candle> stream(List<Candle> candles) async* {
    var last = candles.isNotEmpty ? candles.last.close : seedPrice;
    while (true) {
      await Future<void>.delayed(const Duration(seconds: 1));
      final open = last;
      final close = open * (1 + (_rnd.nextDouble() - 0.5) * 0.002);
      final high = max(open, close) * (1 + _rnd.nextDouble() * 0.0016);
      final low = min(open, close) * (1 - _rnd.nextDouble() * 0.0016);
      final candle = Candle(time: DateTime.now(), open: open, high: high, low: low, close: close);
      last = close;
      yield candle;
    }
  }
}
