import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_pocket_saver/app/controller/pocket_controller.dart';
import 'package:flutter_pocket_saver/app/domain/model/contas.dart';
import 'package:flutter_pocket_saver/app/global/widget/custom_app_bar_widget.dart';
import 'package:flutter_pocket_saver/app/global/widget/stateful_widget.dart';
import 'package:flutter_pocket_saver/app/widgets/card_contas_widget.dart';
import 'package:intl/intl.dart';

class DespesasPage extends StatefulWidget {
  const DespesasPage({super.key});

  @override
  State<DespesasPage> createState() => _DespesasPageState();
}

class _DespesasPageState
    extends WidgetStateful<DespesasPage, PocketController> {
  @override
  void initState() {
    controller.fetchContasByTipo("Despesa");
    super.initState();
  }

  // Função para agrupar despesas por data de vencimento
  Map<String, List<Contas>> _agruparDespesasPorVencimento(List<Contas> contas) {
    final Map<String, List<Contas>> despesasAgrupadas = {};

    // Ordenar por data de vencimento (mais próximas primeiro)
    contas.sort((a, b) => a.dtVencimento.compareTo(b.dtVencimento));

    for (var conta in contas) {
      final dataFormatada = controller.toBRDt(conta.dtVencimento);
      if (!despesasAgrupadas.containsKey(dataFormatada)) {
        despesasAgrupadas[dataFormatada] = [];
      }
      despesasAgrupadas[dataFormatada]!.add(conta);
    }

    return despesasAgrupadas;
  }

  // Função para verificar se a data está próxima do vencimento
  Color _getCorVencimento(DateTime dataVencimento) {
    final hoje = DateTime.now();
    final diferenca = dataVencimento.difference(hoje).inDays;

    if (diferenca < 0) {
      return Colors.red.shade700; // Vencida
    } else if (diferenca <= 3) {
      return Colors.orange; // Próxima de vencer
    } else {
      return Colors.red.shade300; // Ainda tem tempo
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarWidget(title: "Manutenção de Despesas"),
      body: Observer(
        builder: (_) {
          // Agrupar despesas por data de vencimento
          final despesasAgrupadas =
              _agruparDespesasPorVencimento(controller.contas);
          final datasOrdenadas = despesasAgrupadas.keys.toList()
            ..sort((a, b) {
              final dateA = DateFormat('dd/MM/yyyy').parse(a);
              final dateB = DateFormat('dd/MM/yyyy').parse(b);
              return dateA.compareTo(dateB);
            });

          return despesasAgrupadas.isEmpty
              ? const Center(
                  child: Text(
                    "Nenhuma despesa cadastrada",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: datasOrdenadas.length,
                  itemBuilder: (context, indexData) {
                    final data = datasOrdenadas[indexData];
                    final despesasNaData = despesasAgrupadas[data]!;
                    final dataVencimento = DateFormat('dd/MM/yyyy').parse(data);
                    final corVencimento = _getCorVencimento(dataVencimento);

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                                "(${despesasNaData.length} ${despesasNaData.length == 1 ? 'despesa' : 'despesas'})",
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.7),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ...despesasNaData.map((conta) => CardContasWidget(
                              controller: controller,
                              index: controller.contas.indexOf(conta),
                            )),
                        if (indexData < datasOrdenadas.length - 1)
                          const Divider(color: Colors.white24),
                      ],
                    );
                  },
                );
        },
      ),
    );
  }
}
