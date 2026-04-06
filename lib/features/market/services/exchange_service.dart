import '../../trading/models/trading_pair.dart';

abstract class ExchangeService {
  Future<double> fetchTickerPrice(String symbol);
  Stream<double> streamTicker(String symbol);
  Future<List<TradingPair>> fetchTradablePairs();
}
