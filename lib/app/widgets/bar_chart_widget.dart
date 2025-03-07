import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pocket_saver/app/controller/pocket_controller.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

class BarChartWidget extends StatelessWidget {
  final PocketController controller;
  const BarChartWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        Map<DateTime, double> summedByDate = {};

        for (var conta in controller.contas) {
          if (summedByDate.containsKey(conta.dtVencimento)) {
            summedByDate[conta.dtVencimento] =
                summedByDate[conta.dtVencimento]! + conta.valor;
          } else {
            summedByDate[conta.dtVencimento] = conta.valor;
          }
        }

        final sortedDates = summedByDate.keys.toList()
          ..sort((a, b) => a.compareTo(b));

        final DateTime referenceDate =
            controller.contas.isNotEmpty ? sortedDates.first : DateTime.now();

        final double maxY = summedByDate.values.isNotEmpty
            ? summedByDate.values.reduce((a, b) => a > b ? a : b) * 1.2
            : 100;

        return summedByDate.isEmpty
            ? const Center(
                child: Text(
                  "Sem dados para exibir",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              )
            : BarChart(
                BarChartData(
                  gridData: const FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: 20,
                    getDrawingHorizontalLine: _getDrawingLine,
                  ),
                  borderData: FlBorderData(show: false),
                  alignment: BarChartAlignment.spaceAround,
                  maxY: maxY,
                  minY: 0,
                  barGroups: List.generate(sortedDates.length, (index) {
                    DateTime date = sortedDates[index];
                    double summedValue = summedByDate[date]!;
                    final int daysFromReference =
                        date.difference(referenceDate).inDays;

                    return BarChartGroupData(
                      x: daysFromReference,
                      barRods: [
                        BarChartRodData(
                          toY: summedValue,
                          gradient: _getGradient(),
                          width: 18,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(6),
                            topRight: Radius.circular(6),
                          ),
                          backDrawRodData: BackgroundBarChartRodData(
                            show: true,
                            toY: maxY,
                            color: Colors.white.withOpacity(0.05),
                          ),
                        ),
                      ],
                    );
                  }),
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) {
                          if (value == 0) return const SizedBox.shrink();
                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text(
                              'R\$${value.toInt()}',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 10,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          DateTime date =
                              referenceDate.add(Duration(days: value.toInt()));
                          String formattedDate =
                              DateFormat('dd/MM').format(date);
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              formattedDate,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 10,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              );
      },
    );
  }

  static LinearGradient _getGradient() {
    return const LinearGradient(
      colors: [
        Color(0xFF8A2BE2), // BlueViolet
        Color(0xFFDA70D6), // Orchid
      ],
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
    );
  }

  static FlLine _getDrawingLine(double value) {
    return FlLine(
      color: Colors.white.withOpacity(0.1),
      strokeWidth: 1,
      dashArray: [5, 5],
    );
  }
}
