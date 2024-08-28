import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pocket_saver/app/controller/pocket_controller.dart';
import 'package:flutter_pocket_saver/app/global/widget/custom_button_field_container.dart';
import 'package:flutter_pocket_saver/app/global/widget/custom_drop_down_field_container.dart';
import 'package:flutter_pocket_saver/app/global/widget/custom_text_field_container.dart';
import 'package:flutter_pocket_saver/app/global/widget/stateful_widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CustomBillsDialogWidget extends StatefulWidget {
  final String tipo;

  const CustomBillsDialogWidget({super.key, required this.tipo});

  @override
  State<CustomBillsDialogWidget> createState() =>
      _CustomBillsDialogWidgetState();
}

class _CustomBillsDialogWidgetState
    extends WidgetStateful<CustomBillsDialogWidget, PocketController> {
  @override
  void initState() {
    controller.initState();
    controller.changeColor(widget.tipo);
    super.initState();
  }

  final List itens = [
    "teste 1",
    "teste 2",
    "teste 3",
    "teste 4",
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        height: height * 0.7,
        child: Material(
          color: Colors.black,
          borderRadius: BorderRadius.circular(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      widget.tipo,
                      style: TextStyle(
                          color: controller.color,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop(mounted);
                    },
                    icon: Icon(MdiIcons.close),
                  ),
                ],
              ),
              CustomTextFieldContainer(
                controller: controller.edtValor,
                prefixIcon: MdiIcons.currencyBrl,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CentavosInputFormatter(casasDecimais: 2, moeda: false)
                ],
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
              const SizedBox(height: 10),
              CustomButtonFieldContainer(
                  edtController: controller.edtData,
                  tipo: widget.tipo,
                  prefixIcon: MdiIcons.calendar,
                  controller: controller),
              CustomDropDownFieldContainer(
                prefixIcon: MdiIcons.book,
                keyboardType: TextInputType.none,
              ),
              CustomTextFieldContainer(
                controller: controller.edtDescr,
                prefixIcon: MdiIcons.pencil,
                keyboardType: TextInputType.text,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: controller.color,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    await controller.adicionaContas(widget.tipo);
                  },
                  child: Text("Salvar",
                      style: Theme.of(context).textTheme.titleSmall),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
