import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_pocket_saver/app/controller/pocket_controller.dart';
import 'package:flutter_pocket_saver/app/global/widget/stateful_widget.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class CustomDropDownFieldContainer extends StatefulWidget {
  final IconData prefixIcon;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final ValueChanged<String?>? onChanged;
  final String? value;

  const CustomDropDownFieldContainer({
    super.key,
    required this.prefixIcon,
    required this.keyboardType,
    this.inputFormatters,
    this.controller,
    this.onChanged,
    this.value,
  });

  @override
  State<CustomDropDownFieldContainer> createState() =>
      _CustomDropDownFieldContainerState();
}

class _CustomDropDownFieldContainerState
    extends WidgetStateful<CustomDropDownFieldContainer, PocketController> {
  @override
  void initState() {
    super.initState();
    controller.fetchCategorias();
  }

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
          Observer(
            builder: (context) => Expanded(
              child: DropdownButtonHideUnderline(
                child: DropdownButton2<String>(
                  dropdownStyleData: DropdownStyleData(
                    maxHeight: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    offset: const Offset(-10, 0),
                    scrollbarTheme: ScrollbarThemeData(
                      radius: const Radius.circular(40),
                      thickness: WidgetStateProperty.all<double>(6),
                      thumbVisibility: WidgetStateProperty.all<bool>(true),
                    ),
                  ),
                  isExpanded: true,
                  value: controller.categorias.contains(controller.edtCat)
                      ? controller.edtCat
                      : null,
                  onChanged: (String? value) {
                    if (value != null) {
                      if (value == "Adicionar categoria") {
                        _adicionarCategoriaDialog(context);
                      } else {
                        controller.edtCat = value;
                        widget.onChanged?.call(value);
                      }
                    }
                  },
                  hint: Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Selecione a categoria",
                      style: Theme.of(context).textTheme.titleSmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  items: _buildDropdownItems(),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  List<DropdownMenuItem<String>> _buildDropdownItems() {
    // Use a Set to avoid duplicates and ensure unique values
    final uniqueCategorias = controller.categorias.toSet().toList();

    return [
      ...uniqueCategorias.map((String cat) => DropdownMenuItem<String>(
            value: cat,
            child: Text(
              cat,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          )),
      const DropdownMenuItem<String>(
        value: "Adicionar categoria",
        child: Row(
          children: [
            Icon(Icons.add, color: Colors.white),
            SizedBox(width: 8),
            Text(
              "Adicionar categoria",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    ];
  }

  Future<void> _adicionarCategoriaDialog(BuildContext context) async {
    String novaCategoria = "";
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Adicionar Nova Categoria'),
          content: TextField(
            onChanged: (value) {
              novaCategoria = value;
            },
            decoration:
                const InputDecoration(hintText: "Nome da nova categoria"),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Adicionar'),
              onPressed: () {
                if (novaCategoria.isNotEmpty) {
                  controller.adicionarCategoria(novaCategoria);
                  controller.fetchCategorias();
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
