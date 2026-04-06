import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widgets/metric_tile.dart';
import '../../../market/providers/market_providers.dart';
import '../../models/position.dart';
import '../../providers/trading_providers.dart';

class OrderPanel extends ConsumerStatefulWidget {
  const OrderPanel({super.key});

  @override
  ConsumerState<OrderPanel> createState() => _OrderPanelState();
}

class _OrderPanelState extends ConsumerState<OrderPanel> {
  double lots = 0.1;
  final riskController = TextEditingController(text: '1');
  final slController = TextEditingController();
  final tpController = TextEditingController();

  @override
  void dispose() {
    riskController.dispose();
    slController.dispose();
    tpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final money = NumberFormat.currency(symbol: '\$');
    final ticker = ref.watch(tickerStreamProvider).value ?? ref.watch(selectedPairProvider).basePrice;
    final balance = ref.watch(balanceProvider);
    slController.text = slController.text.isEmpty ? (ticker * 0.995).toStringAsFixed(2) : slController.text;
    tpController.text = tpController.text.isEmpty ? (ticker * 1.01).toStringAsFixed(2) : tpController.text;
    final risk = double.tryParse(riskController.text) ?? 1;
    final stopLoss = double.tryParse(slController.text) ?? ticker * 0.995;
    final takeProfit = double.tryParse(tpController.text) ?? ticker * 1.01;

    final calculation = ref.watch(riskCalculatorProvider).calculate(
          balance: balance,
          riskPercent: risk,
          entry: ticker,
          stopLoss: stopLoss,
          takeProfit: takeProfit,
        );

    void submit(Side side) {
      ref.read(positionProvider.notifier).open(
            Position(
              id: DateTime.now().microsecondsSinceEpoch.toString(),
              symbol: ref.read(selectedPairProvider).symbol,
              side: side,
              size: calculation.positionSize * lots,
              entry: ticker,
              stopLoss: stopLoss,
              takeProfit: takeProfit,
            ),
          );
    }

    return GlassPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Order Panel', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          Row(
            children: [
              IconButton(onPressed: () => setState(() => lots = (lots - 0.1).clamp(0.1, 20.0)), icon: const Icon(Icons.remove)),
              Expanded(child: Text('Lot Size: ${lots.toStringAsFixed(1)}', textAlign: TextAlign.center)),
              IconButton(onPressed: () => setState(() => lots = (lots + 0.1).clamp(0.1, 20.0)), icon: const Icon(Icons.add)),
            ],
          ),
          const SizedBox(height: 10),
          TextField(controller: riskController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Risk %')),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: TextField(controller: slController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Stop Loss'))),
              const SizedBox(width: 8),
              Expanded(child: TextField(controller: tpController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Take Profit'))),
            ],
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 12,
            runSpacing: 8,
            children: [
              MetricTile(label: 'Max Loss', value: money.format(calculation.expectedLoss), valueColor: AppColors.sell),
              MetricTile(label: 'Position Size', value: calculation.positionSize.toStringAsFixed(4)),
              MetricTile(label: 'R:R', value: calculation.rewardRisk.toStringAsFixed(2), valueColor: AppColors.buy),
              MetricTile(label: 'Expected Gain', value: money.format(calculation.expectedGain), valueColor: AppColors.buy),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: FilledButton(
                  style: FilledButton.styleFrom(backgroundColor: AppColors.buy),
                  onPressed: () => submit(Side.buy),
                  child: const Text('BUY'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: FilledButton(
                  style: FilledButton.styleFrom(backgroundColor: AppColors.sell),
                  onPressed: () => submit(Side.sell),
                  child: const Text('SELL'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
