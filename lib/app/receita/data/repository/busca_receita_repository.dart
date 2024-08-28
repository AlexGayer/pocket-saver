import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_pocket_saver/app/receita/domain/model/receita.dart';
import 'package:injectable/injectable.dart';

abstract class BuscaReceitaRepository {
  Future<List<Receita>> fetchReceitas();
  Future<void> deleteReceita(int id);
  Future<void> updateReceita(Receita receita);
  Future<void> addReceita(Receita receita);
}

@Injectable(as: BuscaReceitaRepository)
class BuscaReceitaRepositoryImpl implements BuscaReceitaRepository {
  final FirebaseFirestore firestore;

  BuscaReceitaRepositoryImpl(this.firestore);

  @override
  Future<List<Receita>> fetchReceitas() async {
    try {
      final snapshot = await firestore.collection('receitas').get();
      return snapshot.docs.map((doc) => Receita.fromJson(doc.data())).toList();
    } catch (e) {
      throw Exception('Erro ao buscar receitas: $e');
    }
  }

  @override
  Future<void> addReceita(Receita receita) async {
    try {
      await firestore
          .collection('receitas')
          .doc(receita.id.toString())
          .set(receita.toJson());
    } catch (e) {
      throw Exception('Erro ao adicionar receita: $e');
    }
  }

  @override
  Future<void> deleteReceita(int id) async {
    try {
      final receitaQuery = await firestore
          .collection('receitas')
          .where('id', isEqualTo: id)
          .get();

      if (receitaQuery.docs.isNotEmpty) {
        await receitaQuery.docs.first.reference.delete();
      } else {
        throw Exception('Receita não encontrada para o ID: $id');
      }
    } catch (e) {
      throw Exception('Erro ao deletar receita: $e');
    }
  }

  @override
  Future<void> updateReceita(Receita receita) async {
    try {
      final receitaQuery = await firestore
          .collection('receitas')
          .where('id', isEqualTo: receita.id)
          .get();

      if (receitaQuery.docs.isNotEmpty) {
        await receitaQuery.docs.first.reference.update(receita.toJson());
      } else {
        throw Exception('Receita não encontrada para o ID: ${receita.id}');
      }
    } catch (e) {
      throw Exception('Erro ao atualizar receita: $e');
    }
  }
}
