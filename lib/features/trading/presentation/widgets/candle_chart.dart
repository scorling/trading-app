<<<<<<< ours
=======
import 'dart:math';

>>>>>>> theirs
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../market/models/candle.dart';
import '../../../../core/theme/app_theme.dart';

<<<<<<< ours
class CandleChart extends StatelessWidget {
  const CandleChart({super.key, required this.candles});

  final List<Candle> candles;

  @override
  Widget build(BuildContext context) {
    final spots = <FlSpot>[];
    for (var i = 0; i < candles.length; i++) {
      spots.add(FlSpot(i.toDouble(), candles[i].close));
    }

    return LineChart(
      LineChartData(
        minX: 0,
        maxX: (candles.length - 1).toDouble(),
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: const FlTitlesData(show: false),
        lineBarsData: [
          LineChartBarData(
            isCurved: true,
            spots: spots,
            color: AppColors.info,
            barWidth: 2.3,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.info.withValues(alpha: 0.2),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ],
      ),
=======
class CandleChart extends StatefulWidget {
  const CandleChart({
    super.key,
    required this.candles,
    required this.lines,
    required this.onAddLine,
    required this.onMoveLine,
  });

  final List<Candle> candles;
  final List<double> lines;
  final ValueChanged<double> onAddLine;
  final void Function(int index, double price) onMoveLine;

  @override
  State<CandleChart> createState() => _CandleChartState();
}

class _CandleChartState extends State<CandleChart> {
  int? _draggingLineIndex;

  @override
  Widget build(BuildContext context) {
    if (widget.candles.isEmpty) {
      return const SizedBox.shrink();
    }
    final spots = <FlSpot>[];
    for (var i = 0; i < widget.candles.length; i++) {
      spots.add(FlSpot(i.toDouble(), widget.candles[i].close));
    }
    final low = widget.candles.map((e) => e.low).reduce(min);
    final high = widget.candles.map((e) => e.high).reduce(max);
    final margin = (high - low).abs() * 0.12;
    final minY = low - margin;
    final maxY = high + margin;

    return LayoutBuilder(
      builder: (context, constraints) {
        double toPrice(double dy) {
          final ratio = (dy / constraints.maxHeight).clamp(0.0, 1.0);
          return maxY - ((maxY - minY) * ratio);
        }

        double toY(double price) {
          return ((maxY - price) / (maxY - minY)) * constraints.maxHeight;
        }

        int? findClosestLine(double dy) {
          const thresholdPx = 14.0;
          for (var i = 0; i < widget.lines.length; i++) {
            if ((toY(widget.lines[i]) - dy).abs() <= thresholdPx) {
              return i;
            }
          }
          return null;
        }

        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapUp: (details) => widget.onAddLine(toPrice(details.localPosition.dy)),
          onPanStart: (details) {
            _draggingLineIndex = findClosestLine(details.localPosition.dy);
          },
          onPanUpdate: (details) {
            final index = _draggingLineIndex;
            if (index != null) {
              widget.onMoveLine(index, toPrice(details.localPosition.dy));
            }
          },
          onPanEnd: (_) => _draggingLineIndex = null,
          child: Stack(
            children: [
              LineChart(
                LineChartData(
                  minX: 0,
                  maxX: (widget.candles.length - 1).toDouble(),
                  minY: minY,
                  maxY: maxY,
                  gridData: const FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  titlesData: const FlTitlesData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      isCurved: true,
                      spots: spots,
                      color: AppColors.info,
                      barWidth: 2.3,
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppColors.info.withValues(alpha: 0.2),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              for (var i = 0; i < widget.lines.length; i++)
                Positioned(
                  left: 0,
                  right: 0,
                  top: toY(widget.lines[i]),
                  child: IgnorePointer(
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 1.2,
                            color: AppColors.info.withValues(alpha: 0.85),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.72),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.info.withValues(alpha: 0.65)),
                          ),
                          child: Text(
                            widget.lines[i].toStringAsFixed(2),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        );
      },
>>>>>>> theirs
    );
  }
}
