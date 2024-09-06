import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_pocket_saver/app/controller/pocket_controller.dart';
import 'package:flutter_pocket_saver/app/global/widget/custom_app_bar_widget.dart';
import 'package:flutter_pocket_saver/app/global/widget/stateful_widget.dart';
import 'package:flutter_pocket_saver/app/widgets/card_contas_widget.dart';

class DespesasPage extends StatefulWidget {
  const DespesasPage({super.key});

  @override
  State<DespesasPage> createState() => _DespesasPageState();
}

class _DespesasPageState
    extends WidgetStateful<DespesasPage, PocketController> {
  @override
  @override
  void initState() {
    controller.fetchContasByTipo("Despesa");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarWidget(title: "Manutenção de Despesas"),
      body: Observer(
        builder: (_) => Container(
          margin: const EdgeInsets.only(top: 20),
          child: ListView.builder(
            itemCount: controller.contas.length,
            shrinkWrap: true,
            itemBuilder: (context, index) =>
                CardContasWidget(controller: controller, index: index),
          ),
        ),
      ),
    );
  }
}
