import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_pocket_saver/app/controller/pocket_controller.dart';
import 'package:flutter_pocket_saver/app/global/widget/custom_app_bar_widget.dart';
import 'package:flutter_pocket_saver/app/global/widget/stateful_widget.dart';

class ReceitasPage extends StatefulWidget {
  const ReceitasPage({super.key});

  @override
  State<ReceitasPage> createState() => _ReceitasPageState();
}

class _ReceitasPageState
    extends WidgetStateful<ReceitasPage, PocketController> {
  @override
  void initState() {
    controller.fetchContasByTipo("Receita");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarWidget(title: "Receitas"),
      body: Center(
        child: Observer(
          builder: (context) => ListView.builder(
            itemCount: controller.contas.length,
            shrinkWrap: true,
            itemBuilder: (context, index) => Text(
              controller.contas[index].descricao,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
