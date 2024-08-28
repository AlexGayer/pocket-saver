import 'package:flutter_pocket_saver/app/despesa/data/repository/busca_despesa_repository.dart';
import 'package:flutter_pocket_saver/app/despesa/domain/model/despesa.dart';
import 'package:injectable/injectable.dart';

abstract class BuscaDespesaUsecase {
  Future<List<Despesa>> fetchDespesas();
  Future<void> deleteDespesa(int id);
  Future<void> updateDespesa(Despesa despesa);
  Future<void> addDespesa(Despesa despesa);
}

@Injectable(as: BuscaDespesaUsecase)
class BuscaDespesaUsecaseImpl implements BuscaDespesaUsecase {
  final BuscaDespesaRepository despesaRepository;

  BuscaDespesaUsecaseImpl({required this.despesaRepository});

  @override
  Future<List<Despesa>> fetchDespesas() async {
    try {
      return await despesaRepository.fetchDespesas();
    } catch (e) {
      throw Exception('Erro ao buscar despesa: $e');
    }
  }

  @override
  Future<void> addDespesa(Despesa despesa) async {
    try {
      await despesaRepository.addDespesa(despesa);
    } catch (e) {
      throw Exception('Erro ao deletar despesa: $e');
    }
  }

  @override
  Future<void> deleteDespesa(int id) async {
    try {
      await despesaRepository.deleteDespesa(id);
    } catch (e) {
      throw Exception('Erro ao deletar despesa: $e');
    }
  }

  @override
  Future<void> updateDespesa(Despesa despesa) async {
    try {
      await despesaRepository.updateDespesa(despesa);
    } catch (e) {
      throw Exception('Erro ao atualizar despesa: $e');
    }
  }
}
