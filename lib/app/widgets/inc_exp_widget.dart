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
      builder: (_) => Row(
        children: [
          Expanded(
            child: _buildFinanceCard(
              context,
              title: "Receitas",
              value: controller.totalReceitas,
              icon: MdiIcons.arrowUp,
              iconColor: Colors.green,
              backgroundColor: Colors.green.withValues(alpha: 0.15),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildFinanceCard(
              context,
              title: "Despesas",
              value: controller.totalDespesas,
              icon: MdiIcons.arrowDown,
              iconColor: Colors.red,
              backgroundColor: Colors.red.withValues(alpha: 0.15),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFinanceCard(
    BuildContext context, {
    required String title,
    required double value,
    required IconData icon,
    required Color iconColor,
    required Color backgroundColor,
  }) {
    return Card(
      elevation: 0,
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: iconColor.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: iconColor,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              height: 30,
              alignment: Alignment.centerLeft,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  "R\$ ${value.toStringAsFixed(2)}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
