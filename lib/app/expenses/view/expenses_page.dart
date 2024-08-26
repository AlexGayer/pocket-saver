import 'package:flutter/material.dart';
import 'package:flutter_pocket_saver/app/global/widget/custom_app_bar_widget.dart';

class ExpensesPage extends StatefulWidget {
  const ExpensesPage({super.key});

  @override
  State<ExpensesPage> createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBarWidget(title: "Despesas"),
      body: Center(
          child: Text('Despesas Page', style: TextStyle(color: Colors.white))),
    );
  }
}
