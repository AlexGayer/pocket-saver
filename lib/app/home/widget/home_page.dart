import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_pocket_saver/app/global/widget/stateful_widget.dart';
import 'package:flutter_pocket_saver/app/home/components/balance_widget.dart';
import 'package:flutter_pocket_saver/app/home/components/inc_exp_widget.dart';
import 'package:flutter_pocket_saver/app/home/components/container_budget_widget.dart';
import 'package:flutter_pocket_saver/app/home/components/user_widget.dart';
import 'package:flutter_pocket_saver/app/home/controller/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends WidgetStateful<HomePage, HomeController> {
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
