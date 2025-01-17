import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_pocket_saver/app/global/widget/stateful_widget.dart';
import 'package:flutter_pocket_saver/app/controller/pocket_controller.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class IncExpWidget extends StatefulWidget {
  const IncExpWidget({
    super.key,
  });

  @override
  State<IncExpWidget> createState() => _IncExpWidgetState();
}

class _IncExpWidgetState
    extends WidgetStateful<IncExpWidget, PocketController> {
  @override
  void initState() {
    controller.initState();
    controller.fetchAndCalculateTotals();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Icon(MdiIcons.arrowUp, color: Colors.green, size: 30),
                  Text(
                    "R\$ ${controller.totalReceitas.toStringAsFixed(2)}",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(width: 5),
                ],
              ),
              Row(
                children: [
                  Icon(MdiIcons.arrowDown, color: Colors.red, size: 30),
                  const SizedBox(width: 5),
                  Text(
                    "R\$ ${controller.totalDespesas.toStringAsFixed(2)}",
                    style: Theme.of(context).textTheme.titleMedium,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
