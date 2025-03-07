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
    final isReceita = controller.contas[index].tipo == "Receita";
    final color = isReceita ? Colors.green : Colors.red;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                isReceita ? MdiIcons.arrowUp : MdiIcons.arrowDown,
                color: color,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.contas[index].categoria,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Vcto: ${controller.toBRDt(controller.contas[index].dtVencimento)}",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Container(
              constraints: const BoxConstraints(minWidth: 80),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerRight,
                child: Text(
                  controller.formatDouble(controller.contas[index].valor),
                  style: TextStyle(
                    color: color,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
