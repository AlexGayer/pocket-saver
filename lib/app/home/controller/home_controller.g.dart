// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeController on _HomeControllerBase, Store {
  late final _$showCurrencyAtom =
      Atom(name: '_HomeControllerBase.showCurrency', context: context);

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

  late final _$pressedAttentionIndexAtom =
      Atom(name: '_HomeControllerBase.pressedAttentionIndex', context: context);

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
      Atom(name: '_HomeControllerBase.color', context: context);

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

  late final _$initStateAsyncAction =
      AsyncAction('_HomeControllerBase.initState', context: context);

  @override
  Future initState() {
    return _$initStateAsyncAction.run(() => super.initState());
  }

  late final _$datePickerAsyncAction =
      AsyncAction('_HomeControllerBase.datePicker', context: context);

  @override
  Future<dynamic> datePicker(BuildContext context, String? day) {
    return _$datePickerAsyncAction.run(() => super.datePicker(context, day));
  }

  late final _$_HomeControllerBaseActionController =
      ActionController(name: '_HomeControllerBase', context: context);

  @override
  dynamic toogleCurrency() {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.toogleCurrency');
    try {
      return super.toogleCurrency();
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic toggleSelect(int index) {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.toggleSelect');
    try {
      return super.toggleSelect(index);
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeColor(String tipo) {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.changeColor');
    try {
      return super.changeColor(tipo);
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic toBRDt(DateTime? date) {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.toBRDt');
    try {
      return super.toBRDt(date);
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
showCurrency: ${showCurrency},
pressedAttentionIndex: ${pressedAttentionIndex},
color: ${color}
    ''';
  }
}
