import 'package:flutter/material.dart';
import 'package:flutter_pocket_saver/app/global/widget/custom_app_bar_widget.dart';

class IncomesPage extends StatefulWidget {
  const IncomesPage({super.key});

  @override
  State<IncomesPage> createState() => _IncomesPageState();
}

class _IncomesPageState extends State<IncomesPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBarWidget(title: "Receitas"),
      body: Center(
          child: Text('Receitas Page', style: TextStyle(color: Colors.white))),
    );
  }
}
