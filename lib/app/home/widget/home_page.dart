import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_pocket_saver/app/home/components/cards_widget.dart';
import 'package:flutter_pocket_saver/app/home/components/container_budget_widget.dart';
import 'package:flutter_pocket_saver/app/home/components/user_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UserWidget(),
        SizedBox(height: 10),
        CardWidget(),
        ContainerBudgetWidget()
      ],
    );
  }
}
