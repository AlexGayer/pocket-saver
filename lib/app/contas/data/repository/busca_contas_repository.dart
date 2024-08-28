import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_pocket_saver/app/contas/domain/model/contas.dart';
import 'package:injectable/injectable.dart';

abstract class BuscaContasRepository {
  Future<List<Contas>> fetchContas();
  Future<void> addContas(Contas despesa);
  Future<void> deleteContas(int id);
  Future<void> updateContas(Contas despesa);
}

@Injectable(as: BuscaContasRepository)
class BuscaContasRepositoryImpl implements BuscaContasRepository {
  final FirebaseFirestore firestore;

  BuscaContasRepositoryImpl(this.firestore);

  @override
  Future<List<Contas>> fetchContas() async {
    try {
      final snapshot = await firestore.collection('contas').get();
      return snapshot.docs.map((doc) => Contas.fromJson(doc.data())).toList();
    } catch (e) {
      throw Exception('Erro ao buscar contas: $e');
    }
  }

  @override
  Future<void> addContas(Contas contas) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch;

      final newDespesa = Contas(
        id: id,
        tipo: contas.tipo,
        vencimento: contas.vencimento,
        descricao: contas.descricao,
        valor: contas.valor,
      );

      await firestore.collection('contas').doc().set(newDespesa.toJson());
    } catch (e) {
      throw Exception('Erro ao adicionar contas: $e');
    }
  }

  @override
  Future<void> deleteContas(int id) async {
    try {
      final despesaQuery =
          await firestore.collection('contas').where('id', isEqualTo: id).get();

      if (despesaQuery.docs.isNotEmpty) {
        await despesaQuery.docs.first.reference.delete();
      } else {
        throw Exception('contas não encontrada para o ID: $id');
      }
    } catch (e) {
      throw Exception('Erro ao deletar contas: $e');
    }
  }

  @override
  Future<void> updateContas(Contas despesa) async {
    try {
      final despesaQuery = await firestore
          .collection('contas')
          .where('id', isEqualTo: despesa.id)
          .get();

      if (despesaQuery.docs.isNotEmpty) {
        await despesaQuery.docs.first.reference.update(despesa.toJson());
      } else {
        throw Exception('contas não encontrada para o ID: ${despesa.id}');
      }
    } catch (e) {
      throw Exception('Erro ao atualizar contas: $e');
    }
  }
}
