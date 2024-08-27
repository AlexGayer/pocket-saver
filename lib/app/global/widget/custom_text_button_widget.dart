import 'package:flutter/material.dart';

class CustomTextButtonWidget extends StatefulWidget {
  final Future Function() funct;
  final String title;
  final Color color;
  const CustomTextButtonWidget(
      {super.key,
      required this.funct,
      required this.title,
      required this.color});

  @override
  State<CustomTextButtonWidget> createState() => _CustomTextButtonWidgetState();
}

class _CustomTextButtonWidgetState extends State<CustomTextButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      child: TextButton(
        onPressed: widget.funct,
        child: Text(
          widget.title,
          style: TextStyle(color: widget.color),
        ),
      ),
    );
  }
}
