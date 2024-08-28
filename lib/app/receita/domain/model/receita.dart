import 'package:intl/intl.dart';

class Receita {
  final int id;
  final String tipo;
  final String descricao;
  final DateTime vencimento;
  final double valor;

  Receita({
    required this.id,
    required this.tipo,
    required this.descricao,
    required this.vencimento,
    required this.valor,
  });

  factory Receita.fromJson(Map<String, dynamic> json) => Receita(
        id: json['id'],
        tipo: json['tipo'],
        descricao: json['descricao'],
        vencimento: DateFormat("dd/MM/yyyy").parse(json['vencimento']),
        valor: json['valor'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'tipo': tipo,
        'descricao': descricao,
        'vencimento':
            "${vencimento.day.toString().padLeft(2, '0')}/${vencimento.month.toString().padLeft(2, '0')}/${vencimento.year.toString().padLeft(4, '0')}",
        'valor': valor,
      };
}
