import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_pocket_saver/app/controller/pocket_controller.dart';
import 'package:flutter_pocket_saver/app/domain/model/contas.dart';
import 'package:intl/intl.dart';

class MonthlyChartWidget extends StatelessWidget {
  final PocketController controller;

  const MonthlyChartWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white.withValues(alpha: 0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Visão Mensal",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            _buildLegend(),
            const SizedBox(height: 16),
            SizedBox(
              height: 220,
              child: _buildChart(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _legendItem(const Color(0xFF4CAF50), "Receitas"),
        const SizedBox(width: 24),
        _legendItem(const Color(0xFFF44336), "Despesas"),
      ],
    );
  }

  Widget _legendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildChart() {
    return Observer(
      builder: (_) {
        // Agrupar contas por mês
        final Map<String, Map<String, double>> monthlyData =
            _groupByMonth(controller.contas);

        if (monthlyData.isEmpty) {
          return const Center(
            child: Text(
              "Sem dados para exibir",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
          );
        }

        // Ordenar meses cronologicamente
        final sortedMonths = monthlyData.keys.toList()
          ..sort((a, b) {
            final dateA = DateFormat('MM/yyyy').parse(a);
            final dateB = DateFormat('MM/yyyy').parse(b);
            return dateA.compareTo(dateB);
          });

        // Limitar a 6 meses mais recentes para melhor visualização
        final displayMonths = sortedMonths.length > 6
            ? sortedMonths.sublist(sortedMonths.length - 6)
            : sortedMonths;

        // Encontrar o valor máximo para escala do gráfico
        double maxValue = 0;
        for (var month in displayMonths) {
          final receitas = monthlyData[month]!['receitas'] ?? 0;
          final despesas = monthlyData[month]!['despesas'] ?? 0;
          maxValue = [maxValue, receitas, despesas]
              .reduce((curr, next) => curr > next ? curr : next);
        }

        // Adicionar 20% de margem ao valor máximo
        maxValue = maxValue * 1.2;

        return BarChart(
          BarChartData(
            gridData: const FlGridData(
              show: true,
              drawVerticalLine: false,
              horizontalInterval: 1000,
              getDrawingHorizontalLine: _getDrawingLine,
            ),
            borderData: FlBorderData(show: false),
            alignment: BarChartAlignment.spaceAround,
            maxY: maxValue,
            minY: 0,
            groupsSpace: 12,
            barGroups: List.generate(displayMonths.length, (index) {
              final month = displayMonths[index];
              final data = monthlyData[month]!;

              return BarChartGroupData(
                x: index,
                barRods: [
                  // Barra de Receitas
                  BarChartRodData(
                    toY: data['receitas'] ?? 0,
                    color: const Color(0xFF4CAF50),
                    width: 16,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(6),
                      topRight: Radius.circular(6),
                    ),
                    backDrawRodData: BackgroundBarChartRodData(
                      show: true,
                      toY: maxValue,
                      color: Colors.white.withValues(alpha: 0.05),
                    ),
                  ),
                  // Barra de Despesas
                  BarChartRodData(
                    toY: data['despesas'] ?? 0,
                    color: const Color(0xFFF44336),
                    width: 16,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(6),
                      topRight: Radius.circular(6),
                    ),
                    backDrawRodData: BackgroundBarChartRodData(
                      show: true,
                      toY: maxValue,
                      color: Colors.white.withValues(alpha: 0.05),
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
                  reservedSize: 60,
                  getTitlesWidget: (value, meta) {
                    if (value == 0) return const SizedBox.shrink();

                    // Formatar valores grandes de forma mais legível
                    String formattedValue;
                    if (value >= 1000) {
                      formattedValue =
                          'R\$${(value / 1000).toStringAsFixed(1)}k';
                    } else {
                      formattedValue = 'R\$${value.toInt()}';
                    }

                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                        formattedValue,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.7),
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
                    if (value >= displayMonths.length) {
                      return const SizedBox.shrink();
                    }

                    final month = displayMonths[value.toInt()];
                    // Converter MM/yyyy para nome abreviado do mês
                    final date = DateFormat('MM/yyyy').parse(month);
                    final monthName =
                        DateFormat('MMM').format(date).toUpperCase();
                    final year = DateFormat('yy').format(date);

                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        '$monthName/$year',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.7),
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
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

  // Função para agrupar contas por mês
  Map<String, Map<String, double>> _groupByMonth(List<Contas> contas) {
    final Map<String, Map<String, double>> result = {};

    for (var conta in contas) {
      // Formatar a data para MM/yyyy
      final monthYear = DateFormat('MM/yyyy').format(conta.dtVencimento);

      // Inicializar o mês se não existir
      if (!result.containsKey(monthYear)) {
        result[monthYear] = {
          'receitas': 0,
          'despesas': 0,
        };
      }

      // Adicionar valor à categoria correta
      if (conta.tipo == 'Receita') {
        result[monthYear]!['receitas'] =
            (result[monthYear]!['receitas'] ?? 0) + conta.valor;
      } else {
        result[monthYear]!['despesas'] =
            (result[monthYear]!['despesas'] ?? 0) + conta.valor;
      }
    }

    return result;
  }

  static FlLine _getDrawingLine(double value) {
    return FlLine(
      color: Colors.white.withValues(alpha: 0.1),
      strokeWidth: 1,
      dashArray: [5, 5],
    );
  }
}
