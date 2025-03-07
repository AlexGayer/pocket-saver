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
    final isReceita = widget.tipo == "Receita";
    final color = isReceita ? Colors.green : Colors.red;
    final icon = isReceita ? MdiIcons.cashPlus : MdiIcons.cashMinus;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1A1F38),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(color, icon),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle("Valor"),
                  const SizedBox(height: 8),
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
                  const SizedBox(height: 16),
                  _buildSectionTitle("Data de Vencimento"),
                  const SizedBox(height: 8),
                  CustomButtonFieldContainer(
                    edtController: controller.edtVcto,
                    tipo: widget.tipo,
                    prefixIcon: MdiIcons.calendar,
                    controller: controller,
                  ),
                  const SizedBox(height: 16),
                  _buildSectionTitle("Categoria"),
                  const SizedBox(height: 8),
                  CustomDropDownFieldContainer(
                    prefixIcon: MdiIcons.book,
                    keyboardType: TextInputType.none,
                    onChanged: _onDropDownValueChanged,
                  ),
                  const SizedBox(height: 16),
                  _buildSectionTitle("Descrição"),
                  const SizedBox(height: 8),
                  CustomTextFieldContainer(
                    controller: controller.edtDescr,
                    prefixIcon: MdiIcons.pencil,
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 24),
                  _buildSaveButton(color),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                widget.tipo,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.close,
              color: Colors.white.withValues(alpha: 0.7),
              size: 24,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildSaveButton(Color color) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
        onPressed: () async {
          await controller
              .adicionaContas(widget.tipo, controller.edtCat)
              .then((value) => Navigator.of(context).pop());
        },
        child: const Text(
          "Salvar",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
