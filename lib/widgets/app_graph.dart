import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gamelog/core/constants/app_colors.dart';

import '../core/domain/entities/game.dart';

class AppGraph extends StatefulWidget {
  final List<Game> games;
  final void Function()? onTap;
  final String title;

  const AppGraph({super.key, required this.onTap, required this.games, required this.title});





  @override
  State<AppGraph> createState() => _AppGraphState();
}

class _AppGraphState extends State<AppGraph> {

  List<_BarData> _buildDataList() {
    final colors = [
      Colors.red,
      Colors.orangeAccent,
      Colors.purple,
      Colors.blue,
      Colors.green,
    ];

    return List.generate(
      widget.games.length,
          (index) {
        final game = widget.games[index];

        return _BarData(
          colors[index % colors.length],
          (game.totalRatings ?? 0).toDouble(),
          game.backgroundImage ?? '',
        );
      },
    );
  }

  double nextMax() {
    double? max = widget.games.first.totalRatings?.toDouble();
    return ((max! ~/ 10) + 1) * 10;
  }


  BarChartGroupData generateBarGroup(int x, Color color, double value) {
    return BarChartGroupData(
      x: x,
      barRods: [BarChartRodData(toY: value, color: color, width: 20)],
      showingTooltipIndicators: touchedGroupIndex == x ? [0] : [],
    );
  }

  int touchedGroupIndex = -1;

  int rotationTurns = 1;

  @override
  Widget build(BuildContext context) {
    final dataList = _buildDataList();
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.surface
        ),

        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: widget.onTap,
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            AspectRatio(
              aspectRatio: 1.4,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  rotationQuarterTurns: rotationTurns,
                  borderData: FlBorderData(
                    show: true,
                    border: Border.symmetric(
                      horizontal: BorderSide(color: Colors.grey),
                    ),
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    leftTitles: AxisTitles(
                      drawBelowEverything: true,
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 34,
                        getTitlesWidget: (value, meta) {
                          return SideTitleWidget(
                            meta: meta,
                            child: Text(
                              value.toInt().toString(),
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 44,
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();
                          return SideTitleWidget(
                            meta: meta,
                            child: _IconWidget(
                              color: dataList[index].color,
                              isSelected: touchedGroupIndex == index,
                              onTap: () {
                                setState(() {
                                  touchedGroupIndex = index;
                                });
                              },
                              imageUrl: dataList[index].imageUrl,
                            ),
                          );
                        },
                      ),
                    ),
                    rightTitles: const AxisTitles(),
                    topTitles: const AxisTitles(),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    getDrawingHorizontalLine: (value) =>
                        FlLine(color: AppColors.divider, strokeWidth: 0.5),
                  ),
                  barGroups: dataList.asMap().entries.map((e) {
                    final index = e.key;
                    final data = e.value;
                    return generateBarGroup(index, data.color, data.value);
                  }).toList(),
                  maxY: nextMax(),
                  barTouchData: BarTouchData(
                    enabled: true,
                    handleBuiltInTouches: false,
                    touchTooltipData: BarTouchTooltipData(
                      getTooltipColor: (group) => Colors.transparent,
                      tooltipMargin: 5,
                      getTooltipItem:
                          (
                            BarChartGroupData group,
                            int groupIndex,
                            BarChartRodData rod,
                            int rodIndex,
                          ) {
                            return BarTooltipItem(
                              '${rod.toY.toInt()}\n${widget.games[group.x].name}',
                              TextStyle(
                                fontWeight: FontWeight.bold,
                                color: rod.color,
                                fontSize: 12,
                                shadows: const [
                                  Shadow(color: Colors.black26, blurRadius: 2),
                                ],
                              ),
                            );
                          },
                    ),
                    touchCallback: (event, response) {
                      if (event.isInterestedForInteractions &&
                          response != null &&
                          response.spot != null) {
                        setState(() {
                          touchedGroupIndex =
                              response.spot!.touchedBarGroupIndex;
                        });
                      } else {
                        setState(() {
                          touchedGroupIndex = -1;
                        });
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BarData {
  const _BarData(this.color, this.value, this.imageUrl);

  final Color color;
  final double value;
  final String imageUrl;
}

class _IconWidget extends ImplicitlyAnimatedWidget {
  const _IconWidget({
    required this.color,
    required this.isSelected,
    required this.onTap,
    required this.imageUrl,
  }) : super(duration: const Duration(milliseconds: 300));

  final Color color;
  final bool isSelected;
  final VoidCallback onTap;
  final String imageUrl;
  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() =>
      _IconWidgetState();
}

class _IconWidgetState extends AnimatedWidgetBaseState<_IconWidget> {
  Tween<double>? _rotationTween;

  @override
  Widget build(BuildContext context) {
    final rotation = math.pi * 4 * _rotationTween!.evaluate(animation);
    final scale = 1 + _rotationTween!.evaluate(animation) * 0.5;
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: widget.onTap,
      child: Transform(
        transform: Matrix4.rotationZ(rotation)..scale(scale, scale),
        origin: const Offset(20, 20),
        child: SizedBox(
          width: 35,
          height: 35,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: widget.imageUrl != ''
                ? Image.network(widget.imageUrl, fit: BoxFit.cover)
                : Container(
                    height: 150,
                    color: Colors.grey.shade300,
                    child: const Icon(Icons.videogame_asset, size: 48),
                  ),
          ),
        ),
      ),
    );
  }

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _rotationTween =
        visitor(
              _rotationTween,
              widget.isSelected ? 1.0 : 0.0,
              (dynamic value) => Tween<double>(
                begin: value as double,
                end: widget.isSelected ? 1.0 : 0.0,
              ),
            )
            as Tween<double>?;
  }


}
