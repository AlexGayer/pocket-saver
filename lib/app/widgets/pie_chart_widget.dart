import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pocket_saver/app/controller/pocket_controller.dart';
import 'package:flutter_pocket_saver/app/global/widget/custom_color_generator.dart';
import 'package:flutter_pocket_saver/app/global/widget/indicator_widget.dart';
import 'package:flutter_pocket_saver/app/global/widget/stateful_widget.dart';

class PieChartWidget extends StatefulWidget {
  const PieChartWidget({super.key});

  @override
  State<PieChartWidget> createState() => _PieChartWidgetState();
}

class _PieChartWidgetState
    extends WidgetStateful<PieChartWidget, PocketController> {
  int touchedIndex = -1;
  final ColorGenerator colorGenerator = ColorGenerator();

  @override
  void initState() {
    super.initState();
    controller.fetchContas();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, double>>(
      future: controller.agruparContasPorCategoria(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Erro: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('Sem dados para exibir.');
        }

        final categoriasMap = snapshot.data!;
        final categorias = categoriasMap.keys.toList();

        // Gera cores randomicas para as categorias
        final categoriaCores =
            colorGenerator.generateRandomColorsForCategories(categorias);

        return AspectRatio(
          aspectRatio: 1.3,
          child: Row(
            children: <Widget>[
              const SizedBox(height: 18),
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: PieChart(
                    PieChartData(
                      pieTouchData: PieTouchData(
                        touchCallback: (FlTouchEvent event, pieTouchResponse) {
                          setState(() {
                            if (!event.isInterestedForInteractions ||
                                pieTouchResponse == null ||
                                pieTouchResponse.touchedSection == null) {
                              touchedIndex = -1;
                              return;
                            }
                            touchedIndex = pieTouchResponse
                                .touchedSection!.touchedSectionIndex;
                          });
                        },
                      ),
                      borderData: FlBorderData(show: false),
                      sectionsSpace: 0,
                      centerSpaceRadius: 40,
                      sections: showingSections(categoriasMap, categoriaCores),
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: categoriasMap.entries.map((entry) {
                  return Indicator(
                    color: categoriaCores[entry.key]!,
                    text: entry.key,
                    isSquare: true,
                  );
                }).toList(),
              ),
              const SizedBox(width: 28),
            ],
          ),
        );
      },
    );
  }

  List<PieChartSectionData> showingSections(
      Map<String, double> categoriasMap, Map<String, Color> categoriaCores) {
    return categoriasMap.entries.map((entry) {
      final index = categoriasMap.keys.toList().indexOf(entry.key);
      final isTouched = index == touchedIndex;
      final fontSize = isTouched ? 14.0 : 12.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      return PieChartSectionData(
        color: categoriaCores[entry.key]!,
        value: entry.value,
        title: entry.value.toStringAsFixed(1),
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: shadows,
        ),
      );
    }).toList();
  }
}
