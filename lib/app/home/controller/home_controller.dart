import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
part 'home_controller.g.dart';

@injectable
class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final currency = TextEditingController();
  _HomeControllerBase();

  @observable
  bool showCurrency = false;

  @action
  initState() async {
    try {
      currency.text = "R\$ 10.000,00";
    } catch (e) {
      e;
    }
  }

  @action
  toogleCurrency() {
    showCurrency = !showCurrency;
  }
}
