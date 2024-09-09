import 'package:flutter/material.dart';
import 'package:flutter_pocket_saver/app/controller/pocket_controller.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ListTileContasWidget extends StatelessWidget {
  final PocketController controller;
  final int index;

  const ListTileContasWidget(
      {super.key, required this.controller, required this.index});

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;
    return ListTile(
      title: Row(
        children: [
          Icon(
            MdiIcons.circle,
            size: 15,
            color: controller.contas[index].tipo == "Receita"
                ? Colors.green
                : Colors.red,
          ),
          const SizedBox(width: 10),
          Text(controller.contas[index].categoria, style: style.titleSmall),
        ],
      ),
      subtitle: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            controller.formatDouble(controller.contas[index].valor),
            style: style.titleMedium,
          ),
          Text(
            "Vcto: ${controller.toBRDt(controller.contas[index].dtVencimento)}",
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
