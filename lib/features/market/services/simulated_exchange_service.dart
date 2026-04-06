import 'dart:async';
import 'dart:math';

import '../../trading/models/trading_pair.dart';
import 'exchange_service.dart';

class SimulatedExchangeService implements ExchangeService {
  SimulatedExchangeService();

  final _random = Random();
  final Map<String, double> _prices = {
    for (final pair in availablePairs) pair.symbol: pair.basePrice,
  };

  @override
  Future<List<TradingPair>> fetchTradablePairs() async => availablePairs;

  @override
  Future<double> fetchTickerPrice(String symbol) async => _prices[symbol] ?? 0;

  @override
  Stream<double> streamTicker(String symbol) async* {
    while (true) {
      await Future<void>.delayed(const Duration(milliseconds: 650));
      final last = _prices[symbol] ?? 1;
      final volatility = symbol == 'BTCUSDT' ? 0.0018 : 0.003;
      final changeFactor = 1 + ((_random.nextDouble() - 0.5) * volatility);
      final updated = last * changeFactor;
      _prices[symbol] = updated;
      yield updated;
    }
  }
}
