import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CustomTabBarWidget extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  const CustomTabBarWidget(
      {super.key, required this.currentIndex, required this.onTap});

  @override
  State<CustomTabBarWidget> createState() => _CustomTabBarWidgetState();
}

final iconList = <IconData>[
  MdiIcons.home,
  MdiIcons.cash,
  MdiIcons.chartBar,
  MdiIcons.account,
];

class _CustomTabBarWidgetState extends State<CustomTabBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.none,
      color: Colors.black,
      margin: const EdgeInsets.only(bottom: 20),
      child: TabBar(
        dividerColor: Colors.transparent,
        indicatorColor: Colors.lime,
        onTap: widget.onTap,
        tabs: iconList.map((icon) {
          int index = iconList.indexOf(icon);
          return Tab(
            icon: Icon(
              icon,
              size: widget.currentIndex == index ? 27 : 25,
              color: widget.currentIndex == index ? Colors.lime : Colors.white,
            ),
          );
        }).toList(),
      ),
    );
  }
}
