import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../market/providers/market_providers.dart';
import '../../providers/trading_providers.dart';

class PositionList extends ConsumerWidget {
  const PositionList({super.key, this.compact = false});

  final bool compact;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final positions = ref.watch(positionProvider);
    final ticker = ref.watch(tickerStreamProvider).value ?? ref.watch(selectedPairProvider).basePrice;
    final currency = NumberFormat.currency(symbol: '\$');

    if (positions.isEmpty) {
      return const Center(child: Text('No open positions'));
    }

    return ListView.separated(
      shrinkWrap: compact,
      physics: compact ? const NeverScrollableScrollPhysics() : null,
      itemCount: positions.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, i) {
        final p = positions[i];
        final pnl = p.pnl(ticker);
        return GlassPanel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${p.symbol} • ${p.side.name.toUpperCase()}'),
                  Text(currency.format(pnl), style: TextStyle(color: pnl >= 0 ? AppColors.buy : AppColors.sell)),
                ],
              ),
              const SizedBox(height: 6),
              Text('Entry ${p.entry.toStringAsFixed(2)} | SL ${p.stopLoss.toStringAsFixed(2)} | TP ${p.takeProfit.toStringAsFixed(2)}'),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => ref.read(positionProvider.notifier).updateStops(
                            p.id,
                            stopLoss: p.stopLoss * 1.0005,
                            takeProfit: p.takeProfit * 0.9995,
                          ),
                      child: const Text('Adjust SL/TP'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: FilledButton(
                      onPressed: () => ref.read(positionProvider.notifier).close(p.id),
                      style: FilledButton.styleFrom(backgroundColor: AppColors.sell),
                      child: const Text('Close Trade'),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
