import 'package:flutter/material.dart';
import 'package:flutter_pocket_saver/app/global/widget/custom_text_button_widget.dart';
import 'package:flutter_pocket_saver/app/controller/pocket_controller.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class CustomButtonFieldContainer extends StatefulWidget {
  final IconData prefixIcon;
  final String tipo;
  final TextEditingController edtController;
  final PocketController controller;

  const CustomButtonFieldContainer({
    super.key,
    required this.prefixIcon,
    required this.controller,
    required this.tipo,
    required this.edtController,
  });

  @override
  State<CustomButtonFieldContainer> createState() =>
      _CustomButtonFieldContainerState();
}

class _CustomButtonFieldContainerState
    extends State<CustomButtonFieldContainer> {
  final List<String> dates = ["Hoje", "Amanhã", "Outro"];

  @override
  void initState() {
    widget.controller.setColor(widget.tipo);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: .1),
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
              itemBuilder: (context, index) => Observer(
                builder: (_) {
                  if (widget.controller.pressedAttentionIndex == index) {
                    return Container(
                      width: 100,
                      margin: const EdgeInsets.only(left: 10),
                      child: TextField(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        controller: widget.controller.edtVcto,
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: widget.tipo == "Receita"
                                ? Colors.green
                                : Colors.red),
                      ),
                    );
                  } else {
                    return CustomTextButtonWidget(
                      funct: () {
                        setState(() {
                          widget.controller.toggleSelect(index);
                        });

                        return widget.controller
                            .datePicker(context, dates[index]);
                      },
                      title: dates[index],
                      color: Colors.grey,
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
