enum ChartTimeframe { m1, m5, m15, h1, h4, d1 }

extension ChartTimeframeX on ChartTimeframe {
  String get label {
    switch (this) {
      case ChartTimeframe.m1:
        return '1m';
      case ChartTimeframe.m5:
        return '5m';
      case ChartTimeframe.m15:
        return '15m';
      case ChartTimeframe.h1:
        return '1H';
      case ChartTimeframe.h4:
        return '4H';
      case ChartTimeframe.d1:
        return '1D';
    }
  }

  Duration get candleDuration {
    switch (this) {
      case ChartTimeframe.m1:
        return const Duration(minutes: 1);
      case ChartTimeframe.m5:
        return const Duration(minutes: 5);
      case ChartTimeframe.m15:
        return const Duration(minutes: 15);
      case ChartTimeframe.h1:
        return const Duration(hours: 1);
      case ChartTimeframe.h4:
        return const Duration(hours: 4);
      case ChartTimeframe.d1:
        return const Duration(days: 1);
    }
  }

  Duration get simulationInterval {
    switch (this) {
      case ChartTimeframe.m1:
        return const Duration(milliseconds: 900);
      case ChartTimeframe.m5:
        return const Duration(milliseconds: 1050);
      case ChartTimeframe.m15:
        return const Duration(milliseconds: 1200);
      case ChartTimeframe.h1:
        return const Duration(milliseconds: 1400);
      case ChartTimeframe.h4:
        return const Duration(milliseconds: 1600);
      case ChartTimeframe.d1:
        return const Duration(milliseconds: 1900);
    }
  }

  double get volatilityScale {
    switch (this) {
      case ChartTimeframe.m1:
        return 0.0022;
      case ChartTimeframe.m5:
        return 0.0030;
      case ChartTimeframe.m15:
        return 0.0042;
      case ChartTimeframe.h1:
        return 0.0060;
      case ChartTimeframe.h4:
        return 0.0085;
      case ChartTimeframe.d1:
        return 0.0115;
    }
  }
}
