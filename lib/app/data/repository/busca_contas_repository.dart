import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_pocket_saver/app/domain/model/contas.dart';
import 'package:injectable/injectable.dart';

abstract class BuscaContasRepository {
  Future<List<Contas>> fetchContas(String userId);
  Future<List<Contas>> fetchContasByTipo(String userId, String tipo);
  Future<void> addContas(String userId, Contas contas);
  Future<void> deleteContas(String userId, int id);
  Future<void> updateContas(String userId, Contas contas);
}

@Injectable(as: BuscaContasRepository)
class BuscaContasRepositoryImpl implements BuscaContasRepository {
  final FirebaseFirestore firestore;

  BuscaContasRepositoryImpl(this.firestore);

  @override
  Future<List<Contas>> fetchContas(String userId) async {
    try {
      Query query =
          firestore.collection('users').doc(userId).collection('contas');

      final snapshot = await query.get();
      return snapshot.docs
          .map((doc) => Contas.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Erro ao buscar contas: $e');
    }
  }

  @override
  Future<List<Contas>> fetchContasByTipo(String userId, String tipo) async {
    try {
      Query query =
          firestore.collection('users').doc(userId).collection('contas');

      if (tipo.isNotEmpty) {
        query = query.where('tipo', isEqualTo: tipo);
      }

      final snapshot = await query.get();
      return snapshot.docs
          .map((doc) => Contas.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Erro ao buscar contas por tipo: $e');
    }
  }

  @override
  Future<void> addContas(String userId, Contas contas) async {
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

      await firestore
          .collection('users')
          .doc(userId)
          .collection('contas')
          .doc(id.toString())
          .set(newDespesa.toJson());
    } catch (e) {
      throw Exception('Erro ao adicionar contas: $e');
    }
  }

  @override
  Future<void> deleteContas(String userId, int id) async {
    try {
      final despesaQuery = await firestore
          .collection('users')
          .doc(userId)
          .collection('contas')
          .where('id', isEqualTo: id)
          .get();

      if (despesaQuery.docs.isNotEmpty) {
        await despesaQuery.docs.first.reference.delete();
      } else {
        throw Exception('Conta não encontrada para o ID: $id');
      }
    } catch (e) {
      throw Exception('Erro ao deletar conta: $e');
    }
  }

  @override
  Future<void> updateContas(String userId, Contas contas) async {
    try {
      final despesaQuery = await firestore
          .collection('users')
          .doc(userId)
          .collection('contas')
          .where('id', isEqualTo: contas.id)
          .get();

      if (despesaQuery.docs.isNotEmpty) {
        await despesaQuery.docs.first.reference.update(contas.toJson());
      } else {
        throw Exception('Conta não encontrada para o ID: ${contas.id}');
      }
    } catch (e) {
      throw Exception('Erro ao atualizar conta: $e');
    }
  }
}
