import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CustomDropDownFieldContainer extends StatefulWidget {
  final IconData prefixIcon;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;

  const CustomDropDownFieldContainer(
      {super.key,
      required this.prefixIcon,
      required this.keyboardType,
      this.inputFormatters,
      this.controller});

  @override
  State<CustomDropDownFieldContainer> createState() =>
      _CustomDropDownFieldContainerState();
}

class _CustomDropDownFieldContainerState
    extends State<CustomDropDownFieldContainer> {
  List<String> items = ["Casa", "Educação", "Alimentação", "Lazer"];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Icon(widget.prefixIcon),
          ),
          Expanded(
            child: FormBuilderDropdown(
              borderRadius: BorderRadius.zero,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
              initialValue: items.first,
              dropdownColor: Colors.black,
              name: "Categoria",
              onChanged: (value) => value,
              items: items
                  .map((gender) => DropdownMenuItem(
                        alignment: AlignmentDirectional.centerStart,
                        value: gender,
                        child: Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: Text(
                              gender,
                              style: Theme.of(context).textTheme.titleSmall,
                            )),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
