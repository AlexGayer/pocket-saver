import 'package:flutter/material.dart';
import 'package:flutter_pocket_saver/app/controller/pocket_controller.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CardContasWidget extends StatelessWidget {
  final PocketController controller;
  final int index;
  const CardContasWidget(
      {super.key, required this.controller, required this.index});

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;
    final contas = controller.contas[index];

    Color getColor(String tipo) {
      return tipo == "Receita" ? Colors.green : Colors.red;
    }

    String setSub(String tipo) {
      return tipo == "Receita" ? "+" : "-";
    }

    return Card(
      color: Colors.grey.withOpacity(0.1),
      child: Dismissible(
        key: Key("${contas.id}"),
        onDismissed: (direction) {
          controller.contas.removeAt(index);
          controller.deleteContas(contas.id, contas.tipo);
        },
        background: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: Colors.red),
          height: 200,
          child: Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Icon(
                MdiIcons.delete,
                color: Colors.white,
              ),
            ),
          ),
        ),
        child: ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(contas.tipo,
                  style: TextStyle(
                      color: getColor(contas.tipo),
                      fontWeight: FontWeight.bold,
                      fontSize: 18)),
              Text(
                "${setSub(contas.tipo)} ${controller.formatDouble(contas.valor)}",
                style: TextStyle(color: getColor(contas.tipo)),
              ),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                contas.categoria,
                style: style.titleSmall,
              ),
              Text(
                contas.descricao,
                style: style.titleSmall,
              ),
              Text(
                "Vcto: ${controller.toBRDt(contas.dtVencimento)}",
                style: style.titleSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
