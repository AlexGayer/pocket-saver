import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_pocket_saver/app/controller/pocket_controller.dart';
import 'package:flutter_pocket_saver/app/domain/model/contas.dart';
import 'package:flutter_pocket_saver/app/global/widget/stateful_widget.dart';
import 'package:flutter_pocket_saver/app/widgets/list_tile_contas_widget.dart';
import 'package:intl/intl.dart';

class ContainerBudgetWidget extends StatefulWidget {
  const ContainerBudgetWidget({super.key});

  @override
  State<StatefulWidget> createState() => ContainerBudgetWidgetState();
}

class ContainerBudgetWidgetState
    extends WidgetStateful<ContainerBudgetWidget, PocketController> {
  @override
  void initState() {
    controller.fetchContas();
    super.initState();
  }

  // Função para agrupar contas por data de vencimento
  Map<String, List<Contas>> _agruparContasPorVencimento(List<Contas> contas) {
    final Map<String, List<Contas>> contasAgrupadas = {};

    // Filtrar apenas despesas
    final despesas = contas.where((conta) => conta.tipo == "Despesa").toList();

    // Ordenar por data de vencimento (mais próximas primeiro)
    despesas.sort((a, b) => a.dtVencimento.compareTo(b.dtVencimento));

    for (var conta in despesas) {
      final dataFormatada = controller.toBRDt(conta.dtVencimento);
      if (!contasAgrupadas.containsKey(dataFormatada)) {
        contasAgrupadas[dataFormatada] = [];
      }
      contasAgrupadas[dataFormatada]!.add(conta);
    }

    return contasAgrupadas;
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
      return Colors.green; // Ainda tem tempo
    }
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        // Agrupar contas por data de vencimento
        final contasAgrupadas = _agruparContasPorVencimento(controller.contas);
        final datasOrdenadas = contasAgrupadas.keys.toList()
          ..sort((a, b) {
            final dateA = DateFormat('dd/MM/yyyy').parse(a);
            final dateB = DateFormat('dd/MM/yyyy').parse(b);
            return dateA.compareTo(dateB);
          });

        return Card(
          elevation: 0,
          color: Colors.white.withValues(alpha: 0.1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Contas a Vencer",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Implementação futura para ver todas as contas
                      },
                      child: const Text(
                        "Ver Todas",
                        style: TextStyle(
                          color: Colors.purpleAccent,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                contasAgrupadas.isEmpty
                    ? const Center(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            "Nenhuma conta a vencer",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      )
                    : SizedBox(
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: datasOrdenadas.length,
                          itemBuilder: (context, indexData) {
                            final data = datasOrdenadas[indexData];
                            final contasNaData = contasAgrupadas[data]!;
                            final dataVencimento =
                                DateFormat('dd/MM/yyyy').parse(data);
                            final corVencimento =
                                _getCorVencimento(dataVencimento);

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 4,
                                        height: 16,
                                        decoration: BoxDecoration(
                                          color: corVencimento,
                                          borderRadius:
                                              BorderRadius.circular(2),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        data,
                                        style: TextStyle(
                                          color: corVencimento,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        "(${contasNaData.length} ${contasNaData.length == 1 ? 'conta' : 'contas'})",
                                        style: TextStyle(
                                          color: Colors.white
                                              .withValues(alpha: 0.7),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                ...contasNaData.map((conta) => Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 8.0, left: 12.0),
                                      child: ListTileContasWidget(
                                        controller: controller,
                                        index: controller.contas.indexOf(conta),
                                      ),
                                    )),
                                if (indexData < datasOrdenadas.length - 1)
                                  const Divider(color: Colors.white24),
                              ],
                            );
                          },
                        ),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
