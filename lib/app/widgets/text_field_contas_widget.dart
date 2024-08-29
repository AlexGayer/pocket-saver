import 'package:flutter/material.dart';
import 'package:flutter_pocket_saver/app/controller/pocket_controller.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class TextFieldContasWidget extends StatelessWidget {
  final PocketController controller;
  final int index;
  const TextFieldContasWidget(
      {super.key, required this.controller, required this.index});

  @override
  Widget build(BuildContext context) {
    final contas = controller.contas[index];
    Color getColor(String tipo) {
      return tipo == "Receita" ? Colors.green : Colors.red;
    }

    return Card(
      color: Colors.white.withOpacity(0.3),
      child: Dismissible(
        key: Key("${contas.id}"),
        onDismissed: (direction) {
          controller.contas.removeAt(index);
          controller.deleteContas(contas.id, contas.tipo);
        },
        background: Container(
          height: 200,
          color: Colors.red,
          child: Icon(
            MdiIcons.delete,
            color: Colors.white,
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
              Text("R\$ ${contas.valor.toString().replaceAll(".", ",")}"),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(contas.categoria),
              Text(contas.descricao),
              Text(controller.toBRDt(contas.vencimento)),
            ],
          ),
        ),
      ),
    );
  }
}