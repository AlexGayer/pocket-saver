import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_pocket_saver/app/controller/pocket_controller.dart';
import 'package:flutter_pocket_saver/app/global/widget/stateful_widget.dart';

class ContainerBudgetWidget extends StatefulWidget {
  const ContainerBudgetWidget({super.key});

  @override
  State<StatefulWidget> createState() => ContainerBudgetWidgetState();
}

class ContainerBudgetWidgetState
    extends WidgetStateful<ContainerBudgetWidget, PocketController> {
  @override
  void initState() {
    controller.fetchContas();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
        builder: (_) => SizedBox(
              width: double.infinity,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: controller.contas.length,
                itemBuilder: (context, index) =>
                    Text(controller.contas[index].tipo),
              ),
            ));
  }
}
