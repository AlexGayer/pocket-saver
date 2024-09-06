import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_pocket_saver/app/controller/pocket_controller.dart';
import 'package:flutter_pocket_saver/app/global/widget/stateful_widget.dart';
import 'package:flutter_pocket_saver/app/widgets/list_tile_contas_widget.dart';

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
    final size = MediaQuery.of(context).size;
    return Observer(
        builder: (_) => Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Atividades Recentes",
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      height: size.height * 0.2,
                      child: ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.contas.length,
                        itemBuilder: (context, index) => ListTileContasWidget(
                            controller: controller, index: index),
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}
