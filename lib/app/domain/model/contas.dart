import 'package:intl/intl.dart';

class Contas {
  final int id;
  final String tipo;
  final String descricao;
  final String categoria;
  final DateTime dtVencimento;
  final DateTime dtCadastro;
  final double valor;

  Contas({
    required this.id,
    required this.tipo,
    required this.descricao,
    required this.categoria,
    required this.dtVencimento,
    required this.dtCadastro,
    required this.valor,
  });

  factory Contas.fromJson(Map<String, dynamic> json) => Contas(
        id: json['id'],
        tipo: json['tipo'],
        descricao: json['descricao'],
        categoria: json['categoria'],
        dtVencimento: DateFormat("dd/MM/yyyy").parse(json['dtVencimento']),
        dtCadastro: DateFormat("dd/MM/yyyy").parse(json['dtCadastro']),
        valor: json['valor'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'tipo': tipo,
        'descricao': descricao,
        'categoria': categoria,
        'dtVencimento':
            "${dtVencimento.day.toString().padLeft(2, '0')}/${dtVencimento.month.toString().padLeft(2, '0')}/${dtVencimento.year.toString().padLeft(4, '0')}",
        'dtCadastro':
            "${dtCadastro.day.toString().padLeft(2, '0')}/${dtCadastro.month.toString().padLeft(2, '0')}/${dtCadastro.year.toString().padLeft(4, '0')}",
        'valor': valor,
      };
}
