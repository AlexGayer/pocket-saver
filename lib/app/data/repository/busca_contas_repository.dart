import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_pocket_saver/app/domain/model/contas.dart';
import 'package:injectable/injectable.dart';

abstract class BuscaContasRepository {
  Future<List<Contas>> fetchContas();
  Future<List<Contas>> fetchContasByTipo(String tipo);
  Future<void> addContas(Contas contas);
  Future<void> deleteContas(int id);
  Future<void> updateContas(Contas contas);
}

@Injectable(as: BuscaContasRepository)
class BuscaContasRepositoryImpl implements BuscaContasRepository {
  final FirebaseFirestore firestore;

  BuscaContasRepositoryImpl(this.firestore);

  @override
  Future<List<Contas>> fetchContas() async {
    try {
      Query query = firestore.collection('contas');

      final snapshot = await query.get();
      return snapshot.docs
          .map((doc) => Contas.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Erro ao buscar contas: $e');
    }
  }

  @override
  Future<List<Contas>> fetchContasByTipo(String? tipo) async {
    try {
      Query query = firestore.collection('contas');

      if (tipo != null && tipo.isNotEmpty) {
        query = query.where('tipo', isEqualTo: tipo);
      }

      final snapshot = await query.get();
      return snapshot.docs
          .map((doc) => Contas.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
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
        dtVencimento: contas.dtVencimento,
        dtCadastro: contas.dtCadastro,
        descricao: contas.descricao,
        categoria: contas.categoria,
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
  Future<void> updateContas(Contas contas) async {
    try {
      final despesaQuery = await firestore
          .collection('contas')
          .where('id', isEqualTo: contas.id)
          .get();

      if (despesaQuery.docs.isNotEmpty) {
        await despesaQuery.docs.first.reference.update(contas.toJson());
      } else {
        throw Exception('contas não encontrada para o ID: ${contas.id}');
      }
    } catch (e) {
      throw Exception('Erro ao atualizar contas: $e');
    }
  }
}
