import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../logic/risk_calculator.dart';
import '../models/position.dart';

final riskCalculatorProvider = Provider((ref) => const RiskCalculator());

final balanceProvider = StateProvider<double>((ref) => 10000);
final isLiveModeProvider = StateProvider<bool>((ref) => false);

<<<<<<< ours
<<<<<<< ours
=======
=======
>>>>>>> theirs
class ChartLineNotifier extends Notifier<List<double>> {
  @override
  List<double> build() => [];

  void add(double price) => state = [...state, price];

  void updateAt(int index, double price) {
    if (index < 0 || index >= state.length) return;
    final next = [...state];
    next[index] = price;
    state = next;
  }
}

<<<<<<< ours
>>>>>>> theirs
=======
>>>>>>> theirs
class PositionNotifier extends Notifier<List<Position>> {
  @override
  List<Position> build() => [];

  void open(Position position) => state = [...state, position];

  void close(String id) => state = state.where((p) => p.id != id).toList();

  void updateStops(String id, {double? stopLoss, double? takeProfit}) {
    state = [
      for (final p in state)
        if (p.id == id)
          Position(
            id: p.id,
            symbol: p.symbol,
            side: p.side,
            size: p.size,
            entry: p.entry,
            stopLoss: stopLoss ?? p.stopLoss,
            takeProfit: takeProfit ?? p.takeProfit,
          )
        else
          p,
    ];
  }
}

final positionProvider = NotifierProvider<PositionNotifier, List<Position>>(PositionNotifier.new);
<<<<<<< ours
<<<<<<< ours
=======
final chartLinesProvider = NotifierProvider<ChartLineNotifier, List<double>>(ChartLineNotifier.new);
>>>>>>> theirs
=======
final chartLinesProvider = NotifierProvider<ChartLineNotifier, List<double>>(ChartLineNotifier.new);
>>>>>>> theirs
