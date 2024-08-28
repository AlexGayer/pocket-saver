import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_pocket_saver/app/despesa/domain/model/despesa.dart';
import 'package:injectable/injectable.dart';

abstract class BuscaDespesaRepository {
  Future<List<Despesa>> fetchDespesas();
  Future<void> addDespesa(Despesa despesa);
  Future<void> deleteDespesa(int id);
  Future<void> updateDespesa(Despesa despesa);
}

@Injectable(as: BuscaDespesaRepository)
class BuscaDespesaRepositoryImpl implements BuscaDespesaRepository {
  final FirebaseFirestore firestore;

  BuscaDespesaRepositoryImpl(this.firestore);

  @override
  Future<List<Despesa>> fetchDespesas() async {
    try {
      final snapshot = await firestore.collection('despesas').get();
      return snapshot.docs.map((doc) => Despesa.fromJson(doc.data())).toList();
    } catch (e) {
      throw Exception('Erro ao buscar despesas: $e');
    }
  }

  @override
  Future<void> addDespesa(Despesa despesa) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch;

      final newDespesa = Despesa(
        id: id,
        tipo: despesa.tipo,
        vencimento: despesa.vencimento,
        descricao: despesa.descricao,
        valor: despesa.valor,
      );

      await firestore
          .collection('despesas')
          .doc(id.toString())
          .set(newDespesa.toJson());
    } catch (e) {
      throw Exception('Erro ao adicionar despesa: $e');
    }
  }

  @override
  Future<void> deleteDespesa(int id) async {
    try {
      final despesaQuery = await firestore
          .collection('despesas')
          .where('id', isEqualTo: id)
          .get();

      if (despesaQuery.docs.isNotEmpty) {
        await despesaQuery.docs.first.reference.delete();
      } else {
        throw Exception('Despesa não encontrada para o ID: $id');
      }
    } catch (e) {
      throw Exception('Erro ao deletar despesa: $e');
    }
  }

  @override
  Future<void> updateDespesa(Despesa despesa) async {
    try {
      final despesaQuery = await firestore
          .collection('despesas')
          .where('id', isEqualTo: despesa.id)
          .get();

      if (despesaQuery.docs.isNotEmpty) {
        await despesaQuery.docs.first.reference.update(despesa.toJson());
      } else {
        throw Exception('Despesa não encontrada para o ID: ${despesa.id}');
      }
    } catch (e) {
      throw Exception('Erro ao atualizar despesa: $e');
    }
  }
}
