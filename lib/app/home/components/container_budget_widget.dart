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
      height: size.height * 0.5,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black12,
              Colors.black26,
              Colors.black38,
              Colors.black45,
              Colors.black,
              Colors.black,
            ],
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          )),
    );
  }
}
