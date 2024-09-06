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
            ? summedByDate.values.reduce((a, b) => a > b ? a : b)
            : 0;
        final List<Color> colors = [
          Colors.lime,
          Colors.green,
          Colors.blue,
        ];
        final Gradient gradient =
            LinearGradient(colors: colors, begin: Alignment.topCenter);
        return BarChart(
          BarChartData(
            maxY: maxY,
            minY: 0,
            barGroups: List.generate(sortedDates.length, (index) {
              DateTime date = sortedDates[index];
              double summedValue = summedByDate[date]!;

              final int daysFromReference =
                  date.difference(referenceDate).inDays;

              return BarChartGroupData(x: daysFromReference, barRods: [
                BarChartRodData(
                    toY: summedValue, gradient: gradient, width: 15),
              ]);
            }),
            titlesData: FlTitlesData(
              leftTitles:
                  const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              topTitles:
                  const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    DateTime date =
                        referenceDate.add(Duration(days: value.toInt()));

                    String formattedDate = DateFormat('dd/MM').format(date);

                    return Text(
                      formattedDate,
                      style: const TextStyle(fontSize: 10),
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
}
