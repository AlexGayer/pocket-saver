import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_pocket_saver/app/global/widget/stateful_widget.dart';
import 'package:flutter_pocket_saver/app/widgets/balance_widget.dart';
import 'package:flutter_pocket_saver/app/widgets/inc_exp_widget.dart';
import 'package:flutter_pocket_saver/app/widgets/container_budget_widget.dart';
import 'package:flutter_pocket_saver/app/widgets/user_widget.dart';
import 'package:flutter_pocket_saver/app/controller/pocket_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends WidgetStateful<HomePage, PocketController>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    controller.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Atualize os totais sempre que a dependência mudar
    controller.fetchAndCalculateTotals();

    // Verifique se a rota tem argumentos
    final bool? shouldUpdate =
        ModalRoute.of(context)?.settings.arguments as bool?;

    // Se o argumento é true, atualize a tela
    if (shouldUpdate == true) {
      setState(() {
        // Aqui você pode adicionar qualquer lógica que precise ser executada
        // quando a tela deve ser atualizada.
        // Por exemplo, chamar métodos adicionais ou atualizar estados.
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserWidget(),
          BalanceWidget(),
          IncExpWidget(),
          ContainerBudgetWidget(title: "Atividades Recentes"),
          ContainerBudgetWidget(title: "Despesas por Categoria"),
          ContainerBudgetWidget(title: "Receitas por Categoria"),
        ],
      ),
    );
  }
}
