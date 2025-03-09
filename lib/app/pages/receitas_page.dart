import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_pocket_saver/app/controller/pocket_controller.dart';
import 'package:flutter_pocket_saver/app/domain/model/contas.dart';
import 'package:flutter_pocket_saver/app/global/widget/custom_app_bar_widget.dart';
import 'package:flutter_pocket_saver/app/global/widget/stateful_widget.dart';
import 'package:flutter_pocket_saver/app/widgets/card_contas_widget.dart';
import 'package:intl/intl.dart';

class ReceitasPage extends StatefulWidget {
  const ReceitasPage({super.key});

  @override
  State<ReceitasPage> createState() => _ReceitasPageState();
}

class _ReceitasPageState
    extends WidgetStateful<ReceitasPage, PocketController> {
  @override
  void initState() {
    controller.fetchContasByTipo("Receita");
    super.initState();
  }

  // Função para agrupar receitas por data de vencimento
  Map<String, List<Contas>> _agruparReceitasPorVencimento(List<Contas> contas) {
    final Map<String, List<Contas>> receitasAgrupadas = {};

    // Ordenar por data de vencimento (mais próximas primeiro)
    contas.sort((a, b) => a.dtVencimento.compareTo(b.dtVencimento));

    for (var conta in contas) {
      final dataFormatada = controller.toBRDt(conta.dtVencimento);
      if (!receitasAgrupadas.containsKey(dataFormatada)) {
        receitasAgrupadas[dataFormatada] = [];
      }
      receitasAgrupadas[dataFormatada]!.add(conta);
    }

    return receitasAgrupadas;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarWidget(title: "Manutenção de Receitas"),
      body: Observer(
        builder: (_) {
          // Agrupar receitas por data de vencimento
          final receitasAgrupadas =
              _agruparReceitasPorVencimento(controller.contas);
          final datasOrdenadas = receitasAgrupadas.keys.toList()
            ..sort((a, b) {
              final dateA = DateFormat('dd/MM/yyyy').parse(a);
              final dateB = DateFormat('dd/MM/yyyy').parse(b);
              return dateA.compareTo(dateB);
            });

          return receitasAgrupadas.isEmpty
              ? const Center(
                  child: Text(
                    "Nenhuma receita cadastrada",
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
                    final receitasNaData = receitasAgrupadas[data]!;

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
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                data,
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "(${receitasNaData.length} ${receitasNaData.length == 1 ? 'receita' : 'receitas'})",
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.7),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ...receitasNaData.map((conta) => CardContasWidget(
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
