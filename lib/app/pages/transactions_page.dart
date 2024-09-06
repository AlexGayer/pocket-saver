import 'package:flutter/material.dart';
import 'package:flutter_pocket_saver/app/widgets/gradient_background_widget.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  @override
  Widget build(BuildContext context) {
    return const GradientBackgroundWidget(
        child: Center(
      child: Text('Transactions Page', style: TextStyle(color: Colors.white)),
    ));
  }
}
