import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

<<<<<<< ours
<<<<<<< ours
=======
import '../models/chart_timeframe.dart';
>>>>>>> theirs
=======
import '../models/chart_timeframe.dart';
>>>>>>> theirs
import '../../trading/models/trading_pair.dart';
import '../models/candle.dart';
import '../services/simulated_candle_feed.dart';
import '../services/simulated_exchange_service.dart';

final exchangeServiceProvider = Provider<SimulatedExchangeService>((ref) {
  return SimulatedExchangeService();
});

final selectedPairProvider = StateProvider<TradingPair>((ref) => availablePairs.first);
<<<<<<< ours
<<<<<<< ours
=======
final selectedTimeframeProvider = StateProvider<ChartTimeframe>((ref) => ChartTimeframe.m1);
>>>>>>> theirs
=======
final selectedTimeframeProvider = StateProvider<ChartTimeframe>((ref) => ChartTimeframe.m1);
>>>>>>> theirs

final tickerStreamProvider = StreamProvider<double>((ref) {
  final pair = ref.watch(selectedPairProvider);
  final exchange = ref.watch(exchangeServiceProvider);
  return exchange.streamTicker(pair.symbol);
});

class CandleNotifier extends AutoDisposeNotifier<List<Candle>> {
  StreamSubscription<Candle>? _sub;

  @override
  List<Candle> build() {
    final pair = ref.watch(selectedPairProvider);
<<<<<<< ours
<<<<<<< ours
    final feed = SimulatedCandleFeed(pair.basePrice);
=======
=======
>>>>>>> theirs
    final timeframe = ref.watch(selectedTimeframeProvider);
    final feed = SimulatedCandleFeed(
      seedPrice: pair.basePrice,
      timeframe: timeframe,
    );
<<<<<<< ours
>>>>>>> theirs
=======
>>>>>>> theirs
    final initial = feed.bootstrap();
    _sub?.cancel();
    _sub = feed.stream(initial).listen((next) {
      state = [...state.skip(1), next];
    });
    ref.onDispose(() => _sub?.cancel());
    return initial;
  }
}

final candleProvider = AutoDisposeNotifierProvider<CandleNotifier, List<Candle>>(CandleNotifier.new);
