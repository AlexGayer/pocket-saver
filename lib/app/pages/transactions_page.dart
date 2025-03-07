import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_pocket_saver/app/controller/pocket_controller.dart';
import 'package:flutter_pocket_saver/app/global/widget/stateful_widget.dart';
import 'package:flutter_pocket_saver/app/widgets/gradient_background_widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState
    extends WidgetStateful<TransactionsPage, PocketController> {
  String _filterType = "Todos"; // Filtro padrão: Todos
  final List<String> _filterOptions = ["Todos", "Receita", "Despesa"];

  @override
  void initState() {
    controller.initState();
    controller.fetchContas();
    super.initState();
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
              _buildFilterChips(),
              const SizedBox(height: 16),
              _buildTransactionsList(),
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
              "Transações",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            Observer(
              builder: (_) => Text(
                "${controller.contas.length} transações registradas",
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
            // Implementação futura para adicionar nova transação
          },
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.purpleAccent.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              MdiIcons.plus,
              color: Colors.purpleAccent,
              size: 24,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _filterOptions.map((option) {
          final isSelected = _filterType == option;
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
                  _filterType = option;
                });
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTransactionsList() {
    return Expanded(
      child: Observer(
        builder: (_) {
          final filteredContas = _filterType == "Todos"
              ? controller.contas
              : controller.contas
                  .where((conta) => conta.tipo == _filterType)
                  .toList();

          if (filteredContas.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    MdiIcons.cashRemove,
                    size: 64,
                    color: Colors.white.withOpacity(0.3),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Nenhuma transação encontrada",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              await controller.fetchContas();
            },
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: filteredContas.length,
              itemBuilder: (context, index) {
                final conta = filteredContas[index];
                final isReceita = conta.tipo == "Receita";
                final color = isReceita ? Colors.green : Colors.red;
                final icon = isReceita ? MdiIcons.arrowUp : MdiIcons.arrowDown;

                return Dismissible(
                  key: Key("${conta.id}"),
                  background: Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Icon(
                      MdiIcons.delete,
                      color: Colors.white,
                    ),
                  ),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    controller.deleteContas(conta.id, conta.tipo);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Transação removida'),
                        backgroundColor: Colors.red,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    elevation: 0,
                    color: Colors.white.withOpacity(0.1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: color.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              icon,
                              color: color,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  conta.categoria,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  conta.descricao,
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.7),
                                    fontSize: 14,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Vencimento: ${controller.toBRDt(conta.dtVencimento)}",
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.5),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Container(
                            constraints: const BoxConstraints(minWidth: 80),
                            child: Text(
                              "${isReceita ? '+' : '-'} ${controller.formatDouble(conta.valor)}",
                              style: TextStyle(
                                color: color,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
