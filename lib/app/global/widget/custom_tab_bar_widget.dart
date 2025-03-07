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

final List<Map<String, dynamic>> _navItems = [
  {'icon': MdiIcons.home, 'label': 'Início'},
  {'icon': MdiIcons.cash, 'label': 'Finanças'},
  {'icon': MdiIcons.chartBar, 'label': 'Relatórios'},
  {'icon': MdiIcons.account, 'label': 'Perfil'},
];

class _CustomTabBarWidgetState extends State<CustomTabBarWidget> {
  // Cores personalizadas para o tema do aplicativo
  static const Color _selectedColor = Color(0xFFDA70D6); // Orchid
  static const Color _backgroundColor = Color(0xFF1A1F38); // Azul escuro

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.currentIndex,
      onTap: widget.onTap,
      backgroundColor: _backgroundColor,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: _selectedColor,
      unselectedItemColor: Colors.white.withOpacity(0.6),
      showUnselectedLabels: true,
      selectedFontSize: 10,
      unselectedFontSize: 10,
      iconSize: 20,
      elevation: 8,
      items: _navItems.map((item) {
        return BottomNavigationBarItem(
          icon: Icon(item['icon']),
          label: item['label'],
        );
      }).toList(),
    );
  }
}
