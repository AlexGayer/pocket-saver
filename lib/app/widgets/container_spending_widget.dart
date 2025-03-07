import 'package:flutter/material.dart';
import 'package:flutter_pocket_saver/app/controller/pocket_controller.dart';
import 'package:flutter_pocket_saver/app/global/widget/stateful_widget.dart';
import 'package:flutter_pocket_saver/app/widgets/bar_chart_widget.dart';

class ContainerSpendingWidget extends StatefulWidget {
  const ContainerSpendingWidget({super.key});

  @override
  State<StatefulWidget> createState() => ContainerSpendingWidgetState();
}

class ContainerSpendingWidgetState
    extends WidgetStateful<ContainerSpendingWidget, PocketController> {
  final Duration animDuration = const Duration(milliseconds: 250);
  int touchedIndex = -1;

  bool isPlaying = false;

  @override
  void initState() {
    controller.fetchContas();
    super.initState();
  }

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Análise de Gastos",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "Mensal",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.22,
              child: BarChartWidget(controller: controller),
            ),
          ],
        ),
      ),
    );
  }
}
