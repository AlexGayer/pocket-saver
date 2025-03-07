import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_pocket_saver/app/controller/pocket_controller.dart';
import 'package:flutter_pocket_saver/app/global/widget/stateful_widget.dart';
import 'package:flutter_pocket_saver/app/widgets/gradient_background_widget.dart';
import 'package:flutter_pocket_saver/app/widgets/pie_chart_widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState
    extends WidgetStateful<AnalyticsPage, PocketController> {
  String _selectedPeriod = "Mensal";
  final List<String> _periodOptions = ["Semanal", "Mensal", "Anual"];

  @override
  void initState() {
    super.initState();
    controller.fetchContas();
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackgroundWidget(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              _buildHeader(),
              const SizedBox(height: 16),
              _buildPeriodSelector(),
              const SizedBox(height: 16),
              _buildSummaryCards(),
              const SizedBox(height: 24),
              _buildChartSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Análise Financeira",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            Observer(
              builder: (_) => Text(
                "Visualize seus gastos e receitas",
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
        IconButton(
          onPressed: () {
            // Implementação futura para compartilhar relatório
          },
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.purpleAccent.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              MdiIcons.shareVariant,
              color: Colors.purpleAccent,
              size: 24,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPeriodSelector() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _periodOptions.map((option) {
          final isSelected = _selectedPeriod == option;
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: FilterChip(
              selected: isSelected,
              label: Text(option),
              labelStyle: TextStyle(
                color:
                    isSelected ? Colors.white : Colors.white.withOpacity(0.7),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              backgroundColor: Colors.white.withOpacity(0.1),
              selectedColor: Colors.purpleAccent.withOpacity(0.3),
              checkmarkColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              onSelected: (selected) {
                setState(() {
                  _selectedPeriod = option;
                });
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSummaryCards() {
    return Observer(
      builder: (_) => Row(
        children: [
          Expanded(
            child: _buildSummaryCard(
              title: "Receitas",
              value: controller.totalReceitas,
              icon: MdiIcons.arrowUp,
              iconColor: Colors.green,
              backgroundColor: Colors.green.withOpacity(0.15),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildSummaryCard(
              title: "Despesas",
              value: controller.totalDespesas,
              icon: MdiIcons.arrowDown,
              iconColor: Colors.red,
              backgroundColor: Colors.red.withOpacity(0.15),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard({
    required String title,
    required double value,
    required IconData icon,
    required Color iconColor,
    required Color backgroundColor,
  }) {
    return Card(
      elevation: 0,
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: iconColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: iconColor,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              height: 30,
              alignment: Alignment.centerLeft,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  "R\$ ${value.toStringAsFixed(2)}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChartSection() {
    return Expanded(
      child: Card(
        elevation: 0,
        color: Colors.white.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Distribuição de Gastos",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    await controller.fetchContas();
                  },
                  child: const SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: PieChartWidget(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
