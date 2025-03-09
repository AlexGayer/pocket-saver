import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_pocket_saver/app/controller/pocket_controller.dart';
import 'package:flutter_pocket_saver/app/domain/model/contas.dart';
import 'package:flutter_pocket_saver/app/global/widget/stateful_widget.dart';
import 'package:flutter_pocket_saver/app/widgets/gradient_background_widget.dart';
import 'package:intl/intl.dart';
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

  // Função para agrupar transações por data de vencimento
  Map<String, List<Contas>> _agruparTransacoesPorVencimento(
      List<Contas> contas) {
    final Map<String, List<Contas>> transacoesAgrupadas = {};

    // Ordenar por data de vencimento (mais próximas primeiro)
    contas.sort((a, b) => a.dtVencimento.compareTo(b.dtVencimento));

    for (var conta in contas) {
      final dataFormatada = controller.toBRDt(conta.dtVencimento);
      if (!transacoesAgrupadas.containsKey(dataFormatada)) {
        transacoesAgrupadas[dataFormatada] = [];
      }
      transacoesAgrupadas[dataFormatada]!.add(conta);
    }

    return transacoesAgrupadas;
  }

  // Função para verificar se a data está próxima do vencimento
  Color _getCorVencimento(DateTime dataVencimento) {
    final hoje = DateTime.now();
    final diferenca = dataVencimento.difference(hoje).inDays;

    if (diferenca < 0) {
      return Colors.red; // Vencida
    } else if (diferenca <= 3) {
      return Colors.orange; // Próxima de vencer
    } else {
      return Colors.blue; // Ainda tem tempo
    }
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
                  color: Colors.white.withValues(alpha: 0.7),
                  fontSize: 14,
                ),
              ),
            ),
          ],
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
                color: isSelected
                    ? Colors.white
                    : Colors.white.withValues(alpha: 0.7),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              backgroundColor: Colors.white.withValues(alpha: 0.1),
              selectedColor: Colors.purpleAccent.withValues(alpha: 0.3),
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
                    color: Colors.white.withValues(alpha: 0.3),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Nenhuma transação encontrada",
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.7),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            );
          }

          // Agrupar transações por data de vencimento
          final transacoesAgrupadas =
              _agruparTransacoesPorVencimento(filteredContas);
          final datasOrdenadas = transacoesAgrupadas.keys.toList()
            ..sort((a, b) {
              final dateA = DateFormat('dd/MM/yyyy').parse(a);
              final dateB = DateFormat('dd/MM/yyyy').parse(b);
              return dateA.compareTo(dateB);
            });

          return RefreshIndicator(
            onRefresh: () async {
              await controller.fetchContas();
            },
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: datasOrdenadas.length,
              itemBuilder: (context, indexData) {
                final data = datasOrdenadas[indexData];
                final transacoesNaData = transacoesAgrupadas[data]!;
                final dataVencimento = DateFormat('dd/MM/yyyy').parse(data);
                final corVencimento = _getCorVencimento(dataVencimento);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 4.0),
                      child: Row(
                        children: [
                          Container(
                            width: 4,
                            height: 16,
                            decoration: BoxDecoration(
                              color: corVencimento,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            data,
                            style: TextStyle(
                              color: corVencimento,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "(${transacoesNaData.length} ${transacoesNaData.length == 1 ? 'transação' : 'transações'})",
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.7),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ...transacoesNaData.map((conta) {
                      final isReceita = conta.tipo == "Receita";
                      final color = isReceita ? Colors.green : Colors.red;
                      final icon =
                          isReceita ? MdiIcons.arrowUp : MdiIcons.arrowDown;

                      return Dismissible(
                        key: Key("${conta.id}"),
                        background: Container(
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          decoration: BoxDecoration(
                            color: Colors.red.withValues(alpha: 0.8),
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
                          color: Colors.white.withValues(alpha: 0.1),
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
                                    color: color.withValues(alpha: 0.2),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                          color: Colors.white
                                              .withValues(alpha: 0.7),
                                          fontSize: 14,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Container(
                                  constraints:
                                      const BoxConstraints(minWidth: 80),
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
                    }),
                    if (indexData < datasOrdenadas.length - 1)
                      const Divider(color: Colors.white24),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
