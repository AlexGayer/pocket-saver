import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class IncExpWidget extends StatelessWidget {
  const IncExpWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              IconButton(
                icon: Icon(MdiIcons.arrowUpCircle),
                onPressed: () => Navigator.of(context).pushNamed("/incomes"),
                color: Colors.green,
                iconSize: 30,
              ),
              const SizedBox(width: 5),
              Text("R\$ 1.000,00",
                  style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(MdiIcons.arrowDownCircle),
                onPressed: () => Navigator.of(context).pushNamed("/expenses"),
                color: Colors.red,
                iconSize: 30,
              ),
              const SizedBox(width: 5),
              Text("R\$ 2.000,00",
                  style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
        ],
      ),
    );
  }
}
