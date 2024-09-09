import 'package:flutter_pocket_saver/app/data/repository/busca_contas_repository.dart';
import 'package:flutter_pocket_saver/app/domain/model/contas.dart';
import 'package:injectable/injectable.dart';

abstract class BuscaContasUsecase {
  Future<List<Contas>> fetchContas();
  Future<List<Contas>> fetchContasByTipo(String tipo);
  Future<void> deleteContas(int id);
  Future<void> updateContas(Contas contas);
  Future<void> addContas(Contas contas);
}

@Injectable(as: BuscaContasUsecase)
class BuscaContasUsecaseImpl implements BuscaContasUsecase {
  final BuscaContasRepository buscaContasRepository;

  BuscaContasUsecaseImpl({required this.buscaContasRepository});

  @override
  Future<List<Contas>> fetchContas() async {
    try {
      List<Contas> contas = await buscaContasRepository.fetchContas();

      contas.sort((a, b) => b.dtVencimento.compareTo(a.dtVencimento));

      return contas;
    } catch (e) {
      throw Exception('Erro ao buscar Contas: $e');
    }
  }

  @override
  Future<List<Contas>> fetchContasByTipo(String tipo) async {
    try {
      List<Contas> contas = await buscaContasRepository.fetchContasByTipo(tipo);

      contas.sort((a, b) => b.dtVencimento.compareTo(a.dtVencimento));

      return contas;
    } catch (e) {
      throw Exception('Erro ao buscar Contas: $e');
    }
  }

  @override
  Future<void> addContas(Contas contas) async {
    try {
      await buscaContasRepository.addContas(contas);
    } catch (e) {
      throw Exception('Erro ao deletar despesa: $e');
    }
  }

  @override
  Future<void> deleteContas(int id) async {
    try {
      await buscaContasRepository.deleteContas(id);
    } catch (e) {
      throw Exception('Erro ao deletar Contas: $e');
    }
  }

  @override
  Future<void> updateContas(Contas contas) async {
    try {
      await buscaContasRepository.updateContas(contas);
    } catch (e) {
      throw Exception('Erro ao atualizar despesa: $e');
    }
  }
}
