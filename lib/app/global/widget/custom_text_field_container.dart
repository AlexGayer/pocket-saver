import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFieldContainer extends StatefulWidget {
  final IconData? prefixIcon;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final String? hintText;

  const CustomTextFieldContainer(
      {super.key,
      this.prefixIcon,
      this.keyboardType,
      this.inputFormatters,
      this.hintText,
      this.controller});

  @override
  State<CustomTextFieldContainer> createState() =>
      _CustomTextFieldContainerState();
}

class _CustomTextFieldContainerState extends State<CustomTextFieldContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        inputFormatters: widget.inputFormatters,
        decoration: InputDecoration(
          helperText: widget.hintText,
          border: InputBorder.none,
          prefixIcon: Icon(widget.prefixIcon),
        ),
      ),
    );
  }
}
