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
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Saldo Atual", style: TextStyle(color: Colors.white)),
          Observer(
            builder: (_) => TextField(
              obscureText: controller.showCurrency ? false : true,
              style: Theme.of(context).textTheme.titleLarge,
              controller: controller.edtValor,
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: IconButton(
                  icon: Icon(controller.showCurrency
                      ? Icons.visibility
                      : Icons.visibility_off),
                  onPressed: () {
                    controller.toogleCurrency();
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
