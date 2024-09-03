// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pocket_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PocketController on _PocketControllerBase, Store {
  Computed<bool>? _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??= Computed<bool>(() => super.loading,
          name: '_PocketControllerBase.loading'))
      .value;

  late final _$userNameAtom =
      Atom(name: '_PocketControllerBase.userName', context: context);

  @override
  String get userName {
    _$userNameAtom.reportRead();
    return super.userName;
  }

  @override
  set userName(String value) {
    _$userNameAtom.reportWrite(value, super.userName, () {
      super.userName = value;
    });
  }

  late final _$userPhotoURLAtom =
      Atom(name: '_PocketControllerBase.userPhotoURL', context: context);

  @override
  String get userPhotoURL {
    _$userPhotoURLAtom.reportRead();
    return super.userPhotoURL;
  }

  @override
  set userPhotoURL(String value) {
    _$userPhotoURLAtom.reportWrite(value, super.userPhotoURL, () {
      super.userPhotoURL = value;
    });
  }

  late final _$showCurrencyAtom =
      Atom(name: '_PocketControllerBase.showCurrency', context: context);

  @override
  bool get showCurrency {
    _$showCurrencyAtom.reportRead();
    return super.showCurrency;
  }

  @override
  set showCurrency(bool value) {
    _$showCurrencyAtom.reportWrite(value, super.showCurrency, () {
      super.showCurrency = value;
    });
  }

  late final _$_loadingAtom =
      Atom(name: '_PocketControllerBase._loading', context: context);

  @override
  bool get _loading {
    _$_loadingAtom.reportRead();
    return super._loading;
  }

  @override
  set _loading(bool value) {
    _$_loadingAtom.reportWrite(value, super._loading, () {
      super._loading = value;
    });
  }

  late final _$totalReceitasAtom =
      Atom(name: '_PocketControllerBase.totalReceitas', context: context);

  @override
  double get totalReceitas {
    _$totalReceitasAtom.reportRead();
    return super.totalReceitas;
  }

  @override
  set totalReceitas(double value) {
    _$totalReceitasAtom.reportWrite(value, super.totalReceitas, () {
      super.totalReceitas = value;
    });
  }

  late final _$totalDespesasAtom =
      Atom(name: '_PocketControllerBase.totalDespesas', context: context);

  @override
  double get totalDespesas {
    _$totalDespesasAtom.reportRead();
    return super.totalDespesas;
  }

  @override
  set totalDespesas(double value) {
    _$totalDespesasAtom.reportWrite(value, super.totalDespesas, () {
      super.totalDespesas = value;
    });
  }

  late final _$totalContasAtom =
      Atom(name: '_PocketControllerBase.totalContas', context: context);

  @override
  double get totalContas {
    _$totalContasAtom.reportRead();
    return super.totalContas;
  }

  @override
  set totalContas(double value) {
    _$totalContasAtom.reportWrite(value, super.totalContas, () {
      super.totalContas = value;
    });
  }

  late final _$pressedAttentionIndexAtom = Atom(
      name: '_PocketControllerBase.pressedAttentionIndex', context: context);

  @override
  int get pressedAttentionIndex {
    _$pressedAttentionIndexAtom.reportRead();
    return super.pressedAttentionIndex;
  }

  @override
  set pressedAttentionIndex(int value) {
    _$pressedAttentionIndexAtom.reportWrite(value, super.pressedAttentionIndex,
        () {
      super.pressedAttentionIndex = value;
    });
  }

  late final _$colorAtom =
      Atom(name: '_PocketControllerBase.color', context: context);

  @override
  Color? get color {
    _$colorAtom.reportRead();
    return super.color;
  }

  @override
  set color(Color? value) {
    _$colorAtom.reportWrite(value, super.color, () {
      super.color = value;
    });
  }

  late final _$edtCatAtom =
      Atom(name: '_PocketControllerBase.edtCat', context: context);

  @override
  String get edtCat {
    _$edtCatAtom.reportRead();
    return super.edtCat;
  }

  @override
  set edtCat(String value) {
    _$edtCatAtom.reportWrite(value, super.edtCat, () {
      super.edtCat = value;
    });
  }

  late final _$contasAtom =
      Atom(name: '_PocketControllerBase.contas', context: context);

  @override
  List<Contas> get contas {
    _$contasAtom.reportRead();
    return super.contas;
  }

  @override
  set contas(List<Contas> value) {
    _$contasAtom.reportWrite(value, super.contas, () {
      super.contas = value;
    });
  }

  late final _$categoriasAtom =
      Atom(name: '_PocketControllerBase.categorias', context: context);

  @override
  List<String> get categorias {
    _$categoriasAtom.reportRead();
    return super.categorias;
  }

  @override
  set categorias(List<String> value) {
    _$categoriasAtom.reportWrite(value, super.categorias, () {
      super.categorias = value;
    });
  }

  late final _$initStateAsyncAction =
      AsyncAction('_PocketControllerBase.initState', context: context);

  @override
  Future<void> initState() {
    return _$initStateAsyncAction.run(() => super.initState());
  }

  late final _$fetchContasByTipoAsyncAction =
      AsyncAction('_PocketControllerBase.fetchContasByTipo', context: context);

  @override
  Future<void> fetchContasByTipo(String tipo) {
    return _$fetchContasByTipoAsyncAction
        .run(() => super.fetchContasByTipo(tipo));
  }

  late final _$fetchContasAsyncAction =
      AsyncAction('_PocketControllerBase.fetchContas', context: context);

  @override
  Future<void> fetchContas() {
    return _$fetchContasAsyncAction.run(() => super.fetchContas());
  }

  late final _$fetchAndCalculateTotalsAsyncAction = AsyncAction(
      '_PocketControllerBase.fetchAndCalculateTotals',
      context: context);

  @override
  Future<void> fetchAndCalculateTotals() {
    return _$fetchAndCalculateTotalsAsyncAction
        .run(() => super.fetchAndCalculateTotals());
  }

  late final _$adicionaContasAsyncAction =
      AsyncAction('_PocketControllerBase.adicionaContas', context: context);

  @override
  Future<void> adicionaContas(String tipo, String categoria) {
    return _$adicionaContasAsyncAction
        .run(() => super.adicionaContas(tipo, categoria));
  }

  late final _$deleteContasAsyncAction =
      AsyncAction('_PocketControllerBase.deleteContas', context: context);

  @override
  Future<void> deleteContas(int id, String tipo) {
    return _$deleteContasAsyncAction.run(() => super.deleteContas(id, tipo));
  }

  late final _$atualizarContasAsyncAction =
      AsyncAction('_PocketControllerBase.atualizarContas', context: context);

  @override
  Future<void> atualizarContas(Contas contas) {
    return _$atualizarContasAsyncAction
        .run(() => super.atualizarContas(contas));
  }

  late final _$datePickerAsyncAction =
      AsyncAction('_PocketControllerBase.datePicker', context: context);

  @override
  Future<dynamic> datePicker(BuildContext context, String? date) {
    return _$datePickerAsyncAction.run(() => super.datePicker(context, date));
  }

  late final _$_PocketControllerBaseActionController =
      ActionController(name: '_PocketControllerBase', context: context);

  @override
  dynamic toogleCurrency() {
    final _$actionInfo = _$_PocketControllerBaseActionController.startAction(
        name: '_PocketControllerBase.toogleCurrency');
    try {
      return super.toogleCurrency();
    } finally {
      _$_PocketControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic toggleSelect(int index) {
    final _$actionInfo = _$_PocketControllerBaseActionController.startAction(
        name: '_PocketControllerBase.toggleSelect');
    try {
      return super.toggleSelect(index);
    } finally {
      _$_PocketControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setColor(String tipo) {
    final _$actionInfo = _$_PocketControllerBaseActionController.startAction(
        name: '_PocketControllerBase.setColor');
    try {
      return super.setColor(tipo);
    } finally {
      _$_PocketControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic toBRDt(DateTime? date) {
    final _$actionInfo = _$_PocketControllerBaseActionController.startAction(
        name: '_PocketControllerBase.toBRDt');
    try {
      return super.toBRDt(date);
    } finally {
      _$_PocketControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  DateTime? parseData(String data) {
    final _$actionInfo = _$_PocketControllerBaseActionController.startAction(
        name: '_PocketControllerBase.parseData');
    try {
      return super.parseData(data);
    } finally {
      _$_PocketControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String formatDouble(double value, {String? locale, String? pattern}) {
    final _$actionInfo = _$_PocketControllerBaseActionController.startAction(
        name: '_PocketControllerBase.formatDouble');
    try {
      return super.formatDouble(value, locale: locale, pattern: pattern);
    } finally {
      _$_PocketControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  double parseDouble(String valor) {
    final _$actionInfo = _$_PocketControllerBaseActionController.startAction(
        name: '_PocketControllerBase.parseDouble');
    try {
      return super.parseDouble(valor);
    } finally {
      _$_PocketControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic _updateTotalContasController() {
    final _$actionInfo = _$_PocketControllerBaseActionController.startAction(
        name: '_PocketControllerBase._updateTotalContasController');
    try {
      return super._updateTotalContasController();
    } finally {
      _$_PocketControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic showCustomSnackBar(BuildContext ctx, String message) {
    final _$actionInfo = _$_PocketControllerBaseActionController.startAction(
        name: '_PocketControllerBase.showCustomSnackBar');
    try {
      return super.showCustomSnackBar(ctx, message);
    } finally {
      _$_PocketControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
userName: ${userName},
userPhotoURL: ${userPhotoURL},
showCurrency: ${showCurrency},
totalReceitas: ${totalReceitas},
totalDespesas: ${totalDespesas},
totalContas: ${totalContas},
pressedAttentionIndex: ${pressedAttentionIndex},
color: ${color},
edtCat: ${edtCat},
contas: ${contas},
categorias: ${categorias},
loading: ${loading}
    ''';
  }
}
