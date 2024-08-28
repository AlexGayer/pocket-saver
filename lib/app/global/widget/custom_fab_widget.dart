import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_pocket_saver/app/global/widget/custom_bills_dialog_widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CustomFabWidget extends StatefulWidget {
  const CustomFabWidget({super.key});

  @override
  State<CustomFabWidget> createState() => _CustomFabWidgetState();
}

class _CustomFabWidgetState extends State<CustomFabWidget> {
  final _key = GlobalKey<ExpandableFabState>();

  @override
  Widget build(BuildContext context) {
    return ExpandableFab(
      key: _key,
      type: ExpandableFabType.fan,
      distance: 60.0,
      pos: ExpandableFabPos.center,
      childrenAnimation: ExpandableFabAnimation.rotate,
      closeButtonBuilder: RotateFloatingActionButtonBuilder(
        child: const Icon(
          Icons.add,
          color: Colors.lime,
          size: 27,
        ),
        backgroundColor: Colors.transparent,
      ),
      openButtonBuilder: RotateFloatingActionButtonBuilder(
        child: const Icon(Icons.add, color: Colors.lime),
        backgroundColor: Colors.transparent,
      ),
      children: [
        FloatingActionButton(
          backgroundColor: Colors.transparent,
          onPressed: () => showGeneralDialog(
              context: context,
              barrierDismissible: false,
              pageBuilder: (context, anim1, amin2) =>
                  const CustomBillsDialogWidget(tipo: "Receita")),
          heroTag: null,
          child: Icon(
            MdiIcons.cashPlus,
            color: Colors.green,
          ),
        ),
        FloatingActionButton(
          heroTag: null,
          backgroundColor: Colors.transparent,
          onPressed: () => showGeneralDialog(
              context: context,
              barrierDismissible: false,
              pageBuilder: (context, anim1, amin2) =>
                  const CustomBillsDialogWidget(tipo: "Despesa")),
          child: Icon(MdiIcons.cashMinus, color: Colors.red),
        ),
      ],
    );
  }
}
