import 'package:flutter/material.dart';
import 'package:flutter_pocket_saver/app/global/widget/custom_bills_dialog_widget.dart';
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
  {'icon': MdiIcons.plus, 'label': 'Adicionar', 'isCenter': true},
  {'icon': MdiIcons.chartBar, 'label': 'Relatórios'},
  {'icon': MdiIcons.account, 'label': 'Perfil'},
];

class _CustomTabBarWidgetState extends State<CustomTabBarWidget> {
  // Cores personalizadas para o tema do aplicativo
  static const Color _selectedColor = Color(0xFFDA70D6); // Orchid
  static const Color _backgroundColor = Color(0xFF1A1F38); // Azul escuro
  static const Color _addButtonColor = Color(0xFFDA70D6); // Orchid

  void _showAddTransactionDialog(BuildContext context, String tipo) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      pageBuilder: (context, anim1, amin2) =>
          CustomBillsDialogWidget(tipo: tipo),
    );
  }

  void _showAddOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: _backgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Adicionar Transação",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildAddButton(
                  context: context,
                  icon: MdiIcons.cashPlus,
                  label: "Receita",
                  color: Colors.green,
                  onTap: () {
                    Navigator.pop(context);
                    _showAddTransactionDialog(context, "Receita");
                  },
                ),
                _buildAddButton(
                  context: context,
                  icon: MdiIcons.cashMinus,
                  label: "Despesa",
                  color: Colors.red,
                  onTap: () {
                    Navigator.pop(context);
                    _showAddTransactionDialog(context, "Despesa");
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildAddButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 120,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: color,
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Converte o índice da UI para o índice real das telas
  int _getScreenIndex(int uiIndex) {
    if (uiIndex < 2) {
      return uiIndex; // Índices 0 e 1 permanecem os mesmos
    } else if (uiIndex > 2) {
      return uiIndex - 1; // Índices 3 e 4 são mapeados para 2 e 3
    }
    return 0; // Caso padrão (não deve ocorrer)
  }

  // Converte o índice real das telas para o índice da UI
  int _getUIIndex(int screenIndex) {
    if (screenIndex < 2) {
      return screenIndex; // Índices 0 e 1 permanecem os mesmos
    } else {
      return screenIndex + 1; // Índices 2 e 3 são mapeados para 3 e 4
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        height: 60,
        padding: EdgeInsets.zero,
        notchMargin: 8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(_navItems.length, (index) {
            final item = _navItems[index];
            final isCenter = item['isCenter'] == true;

            if (isCenter) {
              return _buildCenterButton(context);
            }

            // Converter o índice da tela atual para o índice da UI para comparação
            final uiIndex = _getUIIndex(widget.currentIndex);
            final isSelected = uiIndex == index;

            return Expanded(
              child: InkWell(
                onTap: () => widget.onTap(_getScreenIndex(index)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      item['icon'],
                      color: isSelected
                          ? _selectedColor
                          : Colors.white.withValues(alpha: 0.6),
                      size: 24,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item['label'],
                      style: TextStyle(
                        color: isSelected
                            ? _selectedColor
                            : Colors.white.withValues(alpha: 0.6),
                        fontSize: 10,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildCenterButton(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () => _showAddOptions(context),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFDA70D6), Color(0xFF8A2BE2)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              _navItems[2]['label'],
              style: const TextStyle(
                color: _addButtonColor,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
