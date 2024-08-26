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

  late final _$initStateAsyncAction =
      AsyncAction('_HomeControllerBase.initState', context: context);

  @override
  Future initState() {
    return _$initStateAsyncAction.run(() => super.initState());
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
  String toString() {
    return '''
showCurrency: ${showCurrency}
    ''';
  }
}
