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
    controller.setColor(widget.tipo);
    super.initState();
  }

  void _onDropDownValueChanged(String? value) {
    setState(() {
      controller.edtCat = value!;
    });
  }

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
                      setState(() {
                        Navigator.of(context).pop(true);
                      });
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
              CustomButtonFieldContainer(
                  edtController: controller.edtVcto,
                  tipo: widget.tipo,
                  prefixIcon: MdiIcons.calendar,
                  controller: controller),
              CustomDropDownFieldContainer(
                prefixIcon: MdiIcons.book,
                keyboardType: TextInputType.none,
                onChanged: _onDropDownValueChanged,
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
                    await controller
                        .adicionaContas(widget.tipo, controller.edtCat)
                        .then((value) => Navigator.of(context).pop(true));
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
