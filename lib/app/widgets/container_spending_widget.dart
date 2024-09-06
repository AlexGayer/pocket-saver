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
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
          width: double.infinity,
          height: size.height * 0.25,
          child: BarChartWidget(controller: controller)),
    );
  }
}
