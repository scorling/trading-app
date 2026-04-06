import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_theme.dart';
import '../../trading/providers/trading_providers.dart';

class AccountScreen extends ConsumerWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final live = ref.watch(isLiveModeProvider);
    final balance = ref.watch(balanceProvider);
    final controller = TextEditingController(text: balance.toStringAsFixed(2));

    return ListView(
      children: [
        const Text('Account', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        GlassPanel(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Mode'),
              SegmentedButton<bool>(
                showSelectedIcon: false,
                segments: const [
                  ButtonSegment(value: false, label: Text('Demo')),
                  ButtonSegment(value: true, label: Text('Live')),
                ],
                selected: {live},
                onSelectionChanged: (set) => ref.read(isLiveModeProvider.notifier).state = set.first,
              )
            ],
          ),
        ),
        const SizedBox(height: 12),
        if (!live)
          GlassPanel(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Demo Balance'),
                const SizedBox(height: 8),
                TextField(controller: controller, keyboardType: TextInputType.number),
                const SizedBox(height: 8),
                FilledButton(
                  onPressed: () {
                    final amount = double.tryParse(controller.text);
                    if (amount != null) {
                      ref.read(balanceProvider.notifier).state = amount;
                    }
                  },
                  child: const Text('Update Balance'),
                )
              ],
            ),
          )
        else
          const GlassPanel(
            child: Text('Live mode enabled. Connect BinanceService/BybitService in exchange layer when credentials are available.'),
          )
      ],
    );
  }
}
