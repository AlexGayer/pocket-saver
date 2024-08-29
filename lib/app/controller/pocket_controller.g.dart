// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pocket_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PocketController on _PocketControllerBase, Store {
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
  Future initState() {
    return _$initStateAsyncAction.run(() => super.initState());
  }

  late final _$fetchContasByTipoAsyncAction =
      AsyncAction('_PocketControllerBase.fetchContasByTipo', context: context);

  @override
  Future<void> fetchContasByTipo(String tipo) {
    return _$fetchContasByTipoAsyncAction
        .run(() => super.fetchContasByTipo(tipo));
  }

  late final _$adicionaContasAsyncAction =
      AsyncAction('_PocketControllerBase.adicionaContas', context: context);

  @override
  Future<void> adicionaContas(String tipo, String categoria) {
    return _$adicionaContasAsyncAction
        .run(() => super.adicionaContas(tipo, categoria));
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
  Future<dynamic> datePicker(BuildContext context, String? day) {
    return _$datePickerAsyncAction.run(() => super.datePicker(context, day));
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
  dynamic changeColor(String tipo) {
    final _$actionInfo = _$_PocketControllerBaseActionController.startAction(
        name: '_PocketControllerBase.changeColor');
    try {
      return super.changeColor(tipo);
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
  double parseDouble(String input) {
    final _$actionInfo = _$_PocketControllerBaseActionController.startAction(
        name: '_PocketControllerBase.parseDouble');
    try {
      return super.parseDouble(input);
    } finally {
      _$_PocketControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void showCustomSnackBar(BuildContext context, String message,
      {Duration duration = const Duration(seconds: 3)}) {
    final _$actionInfo = _$_PocketControllerBaseActionController.startAction(
        name: '_PocketControllerBase.showCustomSnackBar');
    try {
      return super.showCustomSnackBar(context, message, duration: duration);
    } finally {
      _$_PocketControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
showCurrency: ${showCurrency},
pressedAttentionIndex: ${pressedAttentionIndex},
color: ${color},
edtCat: ${edtCat},
contas: ${contas},
categorias: ${categorias}
    ''';
  }
}
