import 'package:flutter_pocket_saver/app/data/repository/busca_contas_repository.dart';
import 'package:flutter_pocket_saver/app/domain/model/contas.dart';
import 'package:injectable/injectable.dart';

abstract class BuscaContasUsecase {
  Future<List<Contas>> fetchContas(String userId);
  Future<List<Contas>> fetchContasByTipo(String userId, String tipo);
  Future<void> addContas(String userId, Contas contas);
  Future<void> deleteContas(String userId, int id);
  Future<void> updateContas(String userId, Contas contas);
}

@Injectable(as: BuscaContasUsecase)
class BuscaContasUsecaseImpl implements BuscaContasUsecase {
  final BuscaContasRepository buscaContasRepository;

  BuscaContasUsecaseImpl({required this.buscaContasRepository});

  @override
  Future<List<Contas>> fetchContas(String userId) async {
    try {
      List<Contas> contas = await buscaContasRepository.fetchContas(userId);

      contas.sort((a, b) => b.dtVencimento.compareTo(a.dtVencimento));

      return contas;
    } catch (e) {
      throw Exception('Erro ao buscar Contas: $e');
    }
  }

  @override
  Future<List<Contas>> fetchContasByTipo(String userId, String tipo) async {
    try {
      List<Contas> contas =
          await buscaContasRepository.fetchContasByTipo(userId, tipo);

      contas.sort((a, b) => b.dtVencimento.compareTo(a.dtVencimento));

      return contas;
    } catch (e) {
      throw Exception('Erro ao buscar Contas: $e');
    }
  }

  @override
  Future<void> addContas(String userId, Contas contas) async {
    try {
      await buscaContasRepository.addContas(userId, contas);
    } catch (e) {
      throw Exception('Erro ao deletar despesa: $e');
    }
  }

  @override
  Future<void> deleteContas(String userId, int id) async {
    try {
      await buscaContasRepository.deleteContas(userId, id);
    } catch (e) {
      throw Exception('Erro ao deletar Contas: $e');
    }
  }

  @override
  Future<void> updateContas(String userId, Contas contas) async {
    try {
      await buscaContasRepository.updateContas(userId, contas);
    } catch (e) {
      throw Exception('Erro ao atualizar despesa: $e');
    }
  }
}
