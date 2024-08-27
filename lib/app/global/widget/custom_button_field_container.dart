import 'package:flutter/material.dart';
import 'package:flutter_pocket_saver/app/global/widget/custom_text_button_widget.dart';
import 'package:flutter_pocket_saver/app/home/controller/home_controller.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// ignore: must_be_immutable
class CustomButtonFieldContainer extends StatefulWidget {
  final IconData prefixIcon;
  final String tipo;
  HomeController controller;

  CustomButtonFieldContainer(
      {super.key,
      required this.prefixIcon,
      required this.controller,
      required this.tipo});

  @override
  State<CustomButtonFieldContainer> createState() =>
      _CustomButtonFieldContainerState();
}

class _CustomButtonFieldContainerState
    extends State<CustomButtonFieldContainer> {
  final List<String> dates = ["Hoje", "Amanhã", "Outro"];

  @override
  void initState() {
    widget.controller.changeColor(widget.tipo);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
              margin: const EdgeInsets.only(left: 10),
              child: Icon(MdiIcons.calendar)),
          Expanded(
            child: ListView.builder(
              itemCount: dates.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => CustomTextButtonWidget(
                funct: () {
                  setState(() {
                    widget.controller.toggleSelect(index);
                  });

                  return widget.controller.datePicker(context, dates[index]);
                },
                title: dates[index],
                color: widget.controller.pressedAttentionIndex == index
                    ? widget.controller.color!
                    : Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
