import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_pocket_saver/app/global/widget/stateful_widget.dart';
import 'package:flutter_pocket_saver/app/controller/pocket_controller.dart';

class BalanceWidget extends StatefulWidget {
  const BalanceWidget({super.key});

  @override
  State<BalanceWidget> createState() => _BalanceWidgetState();
}

class _BalanceWidgetState
    extends WidgetStateful<BalanceWidget, PocketController> {
  @override
  void initState() {
    controller.initState();
    controller.fetchAndCalculateTotals();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white.withOpacity(0.15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Saldo Atual",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Observer(
                  builder: (_) => IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: Icon(
                      controller.showCurrency
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.white70,
                      size: 22,
                    ),
                    onPressed: () {
                      controller.toogleCurrency();
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Observer(
              builder: (_) => Container(
                width: double.infinity,
                height: 40,
                alignment: Alignment.centerLeft,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    controller.showCurrency
                        ? controller.edtValor.text
                        : "R\$ ••••••",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // Implementação futura para adicionar transação
                  },
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text("Adicionar"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purpleAccent.withOpacity(0.7),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
