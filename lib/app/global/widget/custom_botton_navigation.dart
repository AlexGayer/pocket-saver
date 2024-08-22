import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CustomBottonNavigation extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  const CustomBottonNavigation(
      {super.key, required this.currentIndex, required this.onTap});

  @override
  State<CustomBottonNavigation> createState() => _CustomBottonNavigationState();
}

final iconList = <IconData>[
  MdiIcons.home,
  MdiIcons.cash,
  MdiIcons.chartBar,
  MdiIcons.cog,
];

class _CustomBottonNavigationState extends State<CustomBottonNavigation> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBottomNavigationBar.builder(
      backgroundColor: Colors.black,
      tabBuilder: (index, isActive) => Icon(
        iconList[index],
        size: 25,
        color: isActive ? Colors.lime : Colors.white,
      ),
      notchMargin: -50.0,
      notchSmoothness: NotchSmoothness.defaultEdge,
      itemCount: iconList.length,
      activeIndex: widget.currentIndex,
      onTap: widget.onTap,
      gapLocation: GapLocation.center,
    );
  }
}
