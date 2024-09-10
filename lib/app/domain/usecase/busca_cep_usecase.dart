import 'package:flutter_pocket_saver/app/data/repository/busca_cep_repository.dart';
import 'package:flutter_pocket_saver/app/domain/model/cep.dart';
import 'package:injectable/injectable.dart';

abstract class BuscaCepUseCase {
  Future<Cep> call(String cep);
}

@Injectable(as: BuscaCepUseCase)
class BuscaCepUseCaseImpl implements BuscaCepUseCase {
  final BuscaCepRepository _cepRepository;

  BuscaCepUseCaseImpl(this._cepRepository);

  @override
  Future<Cep> call(String cep) async {
    return await _cepRepository.fetchCep(cep);
  }
}
