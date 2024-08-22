import 'package:flutter/material.dart';

class DespesasPage extends StatefulWidget {
  const DespesasPage({super.key});

  @override
  State<DespesasPage> createState() => _DespesasPageState();
}

class _DespesasPageState extends State<DespesasPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text('Despesas Page', style: TextStyle(color: Colors.white)));
  }
}
