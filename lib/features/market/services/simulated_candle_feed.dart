import 'dart:async';
import 'dart:math';

<<<<<<< ours
<<<<<<< ours
import '../models/candle.dart';

class SimulatedCandleFeed {
  SimulatedCandleFeed(this.seedPrice);

  final double seedPrice;
=======
=======
>>>>>>> theirs
import '../models/chart_timeframe.dart';
import '../models/candle.dart';

class SimulatedCandleFeed {
  SimulatedCandleFeed({
    required this.seedPrice,
    required this.timeframe,
  });

  final double seedPrice;
  final ChartTimeframe timeframe;
<<<<<<< ours
>>>>>>> theirs
=======
>>>>>>> theirs
  final _rnd = Random();

  List<Candle> bootstrap({int count = 60}) {
    var price = seedPrice;
    final now = DateTime.now();
    return List.generate(count, (i) {
      final open = price;
<<<<<<< ours
<<<<<<< ours
      final drift = 1 + (_rnd.nextDouble() - 0.5) * 0.002;
      final close = open * drift;
      final high = max(open, close) * (1 + _rnd.nextDouble() * 0.0015);
      final low = min(open, close) * (1 - _rnd.nextDouble() * 0.0015);
      price = close;
      return Candle(
        time: now.subtract(Duration(minutes: count - i)),
=======
=======
>>>>>>> theirs
      final drift = 1 + (_rnd.nextDouble() - 0.5) * timeframe.volatilityScale;
      final close = open * drift;
      final spread = timeframe.volatilityScale * 0.75;
      final high = max(open, close) * (1 + _rnd.nextDouble() * spread);
      final low = min(open, close) * (1 - _rnd.nextDouble() * spread);
      price = close;
      return Candle(
        time: now.subtract(timeframe.candleDuration * (count - i)),
<<<<<<< ours
>>>>>>> theirs
=======
>>>>>>> theirs
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
<<<<<<< ours
<<<<<<< ours
      await Future<void>.delayed(const Duration(seconds: 1));
      final open = last;
      final close = open * (1 + (_rnd.nextDouble() - 0.5) * 0.002);
      final high = max(open, close) * (1 + _rnd.nextDouble() * 0.0016);
      final low = min(open, close) * (1 - _rnd.nextDouble() * 0.0016);
      final candle = Candle(time: DateTime.now(), open: open, high: high, low: low, close: close);
=======
=======
>>>>>>> theirs
      await Future<void>.delayed(timeframe.simulationInterval);
      final open = last;
      final close = open * (1 + (_rnd.nextDouble() - 0.5) * timeframe.volatilityScale);
      final spread = timeframe.volatilityScale * 0.8;
      final high = max(open, close) * (1 + _rnd.nextDouble() * spread);
      final low = min(open, close) * (1 - _rnd.nextDouble() * spread);
      final candle = Candle(
        time: DateTime.now(),
        open: open,
        high: high,
        low: low,
        close: close,
      );
<<<<<<< ours
>>>>>>> theirs
=======
>>>>>>> theirs
      last = close;
      yield candle;
    }
  }
}
