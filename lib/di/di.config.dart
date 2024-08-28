// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:firebase_core/firebase_core.dart' as _i982;
import 'package:flutter_pocket_saver/app/contas/data/repository/busca_contas_repository.dart'
    as _i34;
import 'package:flutter_pocket_saver/app/contas/domain/usecase/busca_contas_usecase.dart'
    as _i150;
import 'package:flutter_pocket_saver/app/home/controller/home_controller.dart'
    as _i261;
import 'package:flutter_pocket_saver/di/firebase_di.dart' as _i774;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final firebaseModule = _$FirebaseModule();
    await gh.factoryAsync<_i982.FirebaseApp>(
      () => firebaseModule.initFirebaseApp,
      preResolve: true,
    );
    gh.factory<_i59.FirebaseAuth>(() => firebaseModule.auth);
    gh.factory<_i974.FirebaseFirestore>(() => firebaseModule.firestore);
    gh.factory<_i34.BuscaContasRepository>(
        () => _i34.BuscaContasRepositoryImpl(gh<_i974.FirebaseFirestore>()));
    gh.factory<_i150.BuscaContasUsecase>(() => _i150.BuscaContasUsecaseImpl(
        buscaContasRepository: gh<_i34.BuscaContasRepository>()));
    gh.factory<_i261.HomeController>(
        () => _i261.HomeController(gh<_i150.BuscaContasUsecase>()));
    return this;
  }
}

class _$FirebaseModule extends _i774.FirebaseModule {}
