import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../trading/providers/trading_providers.dart';

final editableBalanceProvider = StateProvider<String>((ref) {
  final balance = ref.watch(balanceProvider);
  return balance.toStringAsFixed(2);
});
