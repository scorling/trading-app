import 'package:flutter_test/flutter_test.dart';
import 'package:trading_app/features/trading/logic/risk_calculator.dart';

void main() {
  test('calculates risk metrics correctly', () {
    const calculator = RiskCalculator();
    final result = calculator.calculate(
      balance: 10000,
      riskPercent: 1,
      entry: 100,
      stopLoss: 95,
      takeProfit: 110,
    );

    expect(result.riskAmount, 100);
    expect(result.positionSize, 20);
    expect(result.rewardRisk, 2);
    expect(result.expectedGain, 200);
  });
}
