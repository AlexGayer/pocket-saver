import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_pocket_saver/app/controller/pocket_controller.dart';
import 'package:flutter_pocket_saver/app/global/widget/custom_bills_dialog_widget.dart';
import 'package:flutter_pocket_saver/app/global/widget/stateful_widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CustomFabWidget extends StatefulWidget {
  final Function? onDialogClose;
  const CustomFabWidget({super.key, this.onDialogClose});

  @override
  State<CustomFabWidget> createState() => _CustomFabWidgetState();
}

class _CustomFabWidgetState
    extends WidgetStateful<CustomFabWidget, PocketController> {
  final _key = GlobalKey<ExpandableFabState>();

  @override
  Widget build(BuildContext context) {
    return ExpandableFab(
      key: _key,
      type: ExpandableFabType.fan,
      distance: 80.0,
      pos: ExpandableFabPos.center,
      childrenAnimation: ExpandableFabAnimation.none,
      overlayStyle: ExpandableFabOverlayStyle(
        blur: 2.0,
        color: Colors.black.withValues(alpha: 0.5),
      ),
      closeButtonBuilder: DefaultFloatingActionButtonBuilder(
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFDA70D6), Color(0xFF8A2BE2)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: const Icon(
            Icons.close,
            color: Colors.white,
            size: 24,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        backgroundColor: Colors.transparent,
      ),
      openButtonBuilder: DefaultFloatingActionButtonBuilder(
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFDA70D6), Color(0xFF8A2BE2)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 24,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        backgroundColor: Colors.transparent,
      ),
      children: [
        _buildFabItem(
          icon: MdiIcons.cashPlus,
          label: "Receita",
          color: Colors.green,
          onTap: () {
            _key.currentState?.toggle();
            showGeneralDialog(
              context: context,
              barrierDismissible: false,
              pageBuilder: (context, anim1, amin2) =>
                  const CustomBillsDialogWidget(tipo: "Receita"),
            );
          },
        ),
        _buildFabItem(
          icon: MdiIcons.cashMinus,
          label: "Despesa",
          color: Colors.red,
          onTap: () {
            _key.currentState?.toggle();
            showGeneralDialog(
              context: context,
              barrierDismissible: false,
              pageBuilder: (context, anim1, amin2) =>
                  const CustomBillsDialogWidget(tipo: "Despesa"),
            );
          },
        ),
      ],
    );
  }

  Widget _buildFabItem({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return FloatingActionButton.extended(
      heroTag: label,
      backgroundColor: Colors.white,
      foregroundColor: color,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      onPressed: onTap,
      label: Text(
        label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
      icon: Icon(
        icon,
        color: color,
      ),
    );
  }
}
