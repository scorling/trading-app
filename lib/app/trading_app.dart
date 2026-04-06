import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';
import '../features/account/screens/account_screen.dart';
import '../features/trading/screens/dashboard_screen.dart';
import '../features/trading/screens/positions_screen.dart';

class TradingApp extends StatelessWidget {
  const TradingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      home: const _Shell(),
    );
  }
}

class _Shell extends StatefulWidget {
  const _Shell();

  @override
  State<_Shell> createState() => _ShellState();
}

class _ShellState extends State<_Shell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    const pages = [DashboardScreen(), PositionsScreen(), AccountScreen()];
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(12),
        child: pages[_index],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (value) => setState(() => _index = value),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.candlestick_chart), label: 'Trade'),
          NavigationDestination(icon: Icon(Icons.workspaces_outline), label: 'Positions'),
          NavigationDestination(icon: Icon(Icons.person_outline), label: 'Account'),
        ],
      ),
    );
  }
}
