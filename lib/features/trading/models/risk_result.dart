class RiskResult {
  const RiskResult({
    required this.riskAmount,
    required this.positionSize,
    required this.rewardRisk,
    required this.expectedGain,
    required this.expectedLoss,
  });

  final double riskAmount;
  final double positionSize;
  final double rewardRisk;
  final double expectedGain;
  final double expectedLoss;
}
