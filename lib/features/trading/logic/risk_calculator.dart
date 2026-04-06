import '../models/risk_result.dart';

class RiskCalculator {
  const RiskCalculator();

  RiskResult calculate({
    required double balance,
    required double riskPercent,
    required double entry,
    required double stopLoss,
    required double takeProfit,
  }) {
    final riskAmount = balance * (riskPercent / 100);
    final stopDistance = (entry - stopLoss).abs();
    final targetDistance = (takeProfit - entry).abs();
    final safeDistance = stopDistance <= 0 ? 0.0000001 : stopDistance;
    final positionSize = riskAmount / safeDistance;
    final expectedGain = positionSize * targetDistance;
<<<<<<< ours
    final rewardRisk = riskAmount == 0 ? 0 : expectedGain / riskAmount;
=======
    final rewardRisk = (riskAmount == 0 ? 0 : expectedGain / riskAmount).toDouble();
>>>>>>> theirs

    return RiskResult(
      riskAmount: riskAmount,
      positionSize: positionSize,
      rewardRisk: rewardRisk,
      expectedGain: expectedGain,
      expectedLoss: riskAmount,
    );
  }
}
