import 'package:flutter_pocket_saver/app/receita/data/repository/busca_receita_repository.dart';
import 'package:flutter_pocket_saver/app/receita/domain/model/receita.dart';
import 'package:injectable/injectable.dart';

abstract class BuscaReceitaUsecase {
  Future<List<Receita>> fetchReceitas();
  Future<void> deleteReceita(int id);
  Future<void> updateReceita(Receita receita);
  Future<void> addReceita(Receita receita);
}

@Injectable(as: BuscaReceitaUsecase)
class BuscaReceitaUsecaseImpl implements BuscaReceitaUsecase {
  final BuscaReceitaRepository receitaRepository;

  BuscaReceitaUsecaseImpl({required this.receitaRepository});

  @override
  Future<List<Receita>> fetchReceitas() async {
    try {
      return await receitaRepository.fetchReceitas();
    } catch (e) {
      throw Exception('Erro ao buscar receitas: $e');
    }
  }

  @override
  Future<void> deleteReceita(int id) async {
    try {
      await receitaRepository.deleteReceita(id);
    } catch (e) {
      throw Exception('Erro ao deletar receita: $e');
    }
  }

  @override
  Future<void> updateReceita(Receita receita) async {
    try {
      await receitaRepository.updateReceita(receita);
    } catch (e) {
      throw Exception('Erro ao atualizar receita: $e');
    }
  }

  @override
  Future<void> addReceita(Receita receita) async {
    try {
      await receitaRepository.addReceita(receita);
    } catch (e) {
      throw Exception('Erro ao atualizar receita: $e');
    }
  }
}
