enum Side { buy, sell }

class Position {
  Position({
    required this.id,
    required this.symbol,
    required this.side,
    required this.size,
    required this.entry,
    required this.stopLoss,
    required this.takeProfit,
  });

  final String id;
  final String symbol;
  final Side side;
  final double size;
  final double entry;
  final double stopLoss;
  final double takeProfit;

  double pnl(double currentPrice) {
    final diff = side == Side.buy ? currentPrice - entry : entry - currentPrice;
    return diff * size;
  }
}
