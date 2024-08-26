import 'package:flutter/material.dart';

class ContainerBudgetWidget extends StatefulWidget {
  final String title;
  const ContainerBudgetWidget({super.key, required this.title});

  @override
  State<ContainerBudgetWidget> createState() => _ContainerBudgetWidgetState();
}

class _ContainerBudgetWidgetState extends State<ContainerBudgetWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
      width: size.width,
      height: size.height * 0.2,
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          )),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(widget.title),
      ),
    );
  }
}
