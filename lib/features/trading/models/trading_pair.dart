class TradingPair {
  const TradingPair({required this.symbol, required this.basePrice, required this.spread});

  final String symbol;
  final double basePrice;
  final double spread;
}

const availablePairs = [
  TradingPair(symbol: 'BTCUSDT', basePrice: 69350, spread: 2.8),
  TradingPair(symbol: 'ETHUSDT', basePrice: 3410, spread: 1.6),
  TradingPair(symbol: 'SOLUSDT', basePrice: 186, spread: 0.5),
  TradingPair(symbol: 'XRPUSDT', basePrice: 0.64, spread: 0.01),
];
