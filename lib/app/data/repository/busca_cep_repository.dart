import 'package:dio/dio.dart';
import 'package:flutter_pocket_saver/app/domain/model/cep.dart';
import 'package:injectable/injectable.dart';

abstract class BuscaCepRepository {
  Future<Cep> fetchCep(String cep);
}

@Injectable(as: BuscaCepRepository)
class BuscaCepRepositoryImpl implements BuscaCepRepository {
  final Dio dio;

  BuscaCepRepositoryImpl(this.dio);

  @override
  Future<Cep> fetchCep(String cep) async {
    try {
      final response = await dio.get('https://viacep.com.br/ws/$cep/json/');
      if (response.statusCode == 200) {
        return Cep.fromJson(response.data);
      } else {
        throw Exception('CEP não encontrado!');
      }
    } on DioException catch (e) {
      print('Erro na requisição: $e');
      throw Exception('Erro ao buscar CEP!');
    }
  }
}
