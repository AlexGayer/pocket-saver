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

class _HomePageState extends WidgetStateful<HomePage, PocketController> {
  @override
  void initState() {
    controller.initState();
    super.initState();
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
