import 'package:flutter/material.dart';

class ContainerBudgetWidget extends StatefulWidget {
  const ContainerBudgetWidget({super.key});

  @override
  State<ContainerBudgetWidget> createState() => _ContainerBudgetWidgetState();
}

class _ContainerBudgetWidgetState extends State<ContainerBudgetWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      width: size.width,
      height: size.height * 0.4,
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          )),
      child: const Text("data"),
    );
  }
}
