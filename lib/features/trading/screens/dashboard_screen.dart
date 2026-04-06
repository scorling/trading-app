import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/metric_tile.dart';
<<<<<<< ours
<<<<<<< ours
=======
import '../../market/models/chart_timeframe.dart';
>>>>>>> theirs
=======
import '../../market/models/chart_timeframe.dart';
>>>>>>> theirs
import '../../market/providers/market_providers.dart';
import '../models/trading_pair.dart';
import '../presentation/widgets/candle_chart.dart';
import '../presentation/widgets/order_panel.dart';
import '../presentation/widgets/position_list.dart';
import '../providers/trading_providers.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pair = ref.watch(selectedPairProvider);
    final ticker = ref.watch(tickerStreamProvider).value ?? pair.basePrice;
    final candles = ref.watch(candleProvider);
<<<<<<< ours
<<<<<<< ours
=======
    final timeframe = ref.watch(selectedTimeframeProvider);
    final lines = ref.watch(chartLinesProvider);
>>>>>>> theirs
=======
    final timeframe = ref.watch(selectedTimeframeProvider);
    final lines = ref.watch(chartLinesProvider);
>>>>>>> theirs
    final balance = ref.watch(balanceProvider);

    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<TradingPair>(
<<<<<<< ours
<<<<<<< ours
<<<<<<< ours
<<<<<<< ours
                  value: pair,
=======
                  initialValue: pair,
>>>>>>> theirs
=======
                  initialValue: pair,
>>>>>>> theirs
=======
                  initialValue: pair,
>>>>>>> theirs
=======
                  initialValue: pair,
>>>>>>> theirs
                  decoration: const InputDecoration(labelText: 'Asset'),
                  items: [
                    for (final item in availablePairs)
                      DropdownMenuItem(value: item, child: Text(item.symbol)),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      ref.read(selectedPairProvider.notifier).state = value;
                    }
                  },
                ),
              ),
              const SizedBox(width: 12),
              GlassPanel(
                padding: const EdgeInsets.all(10),
                child: MetricTile(label: 'Balance', value: '\$${balance.toStringAsFixed(2)}'),
              )
            ],
          ),
          const SizedBox(height: 12),
          GlassPanel(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(pair.symbol, style: Theme.of(context).textTheme.titleLarge),
                    Text(
                      ticker.toStringAsFixed(2),
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: AppColors.info),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Spread ${pair.spread.toStringAsFixed(2)}', style: const TextStyle(color: AppColors.textSecondary)),
                ),
                const SizedBox(height: 12),
<<<<<<< ours
<<<<<<< ours
                SizedBox(height: 260, child: CandleChart(candles: candles)),
=======
=======
>>>>>>> theirs
                SizedBox(
                  height: 36,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: ChartTimeframe.values.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final item = ChartTimeframe.values[index];
                      final selected = item == timeframe;
                      return ChoiceChip(
                        selected: selected,
                        label: Text(item.label),
                        onSelected: (_) {
                          ref.read(selectedTimeframeProvider.notifier).state = item;
                        },
                        selectedColor: AppColors.info.withValues(alpha: 0.25),
                        side: BorderSide(
                          color: selected ? AppColors.info : Colors.white24,
                        ),
                        labelStyle: TextStyle(
                          color: selected ? Colors.white : AppColors.textSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 260,
                  child: CandleChart(
                    candles: candles,
                    lines: lines,
                    onAddLine: (price) => ref.read(chartLinesProvider.notifier).add(price),
                    onMoveLine: (index, price) => ref.read(chartLinesProvider.notifier).updateAt(index, price),
                  ),
                ),
<<<<<<< ours
>>>>>>> theirs
=======
>>>>>>> theirs
              ],
            ),
          ),
          const SizedBox(height: 12),
          const OrderPanel(),
          const SizedBox(height: 12),
          const GlassPanel(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Open Positions'),
                SizedBox(height: 10),
                PositionList(compact: true),
              ],
            ),
          )
        ],
      ),
    );
  }
}
