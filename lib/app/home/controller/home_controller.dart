import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
part 'home_controller.g.dart';

@injectable
// ignore: library_private_types_in_public_api
class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final currency = TextEditingController();
  final bills = TextEditingController();
  final dateCtrl = TextEditingController();
  final billsNode = FocusNode();

  TimeOfDay timeOfDay = TimeOfDay.now();
  DateTime selectedDate = DateTime.now();
  DateTime firstDate = DateTime(2024);
  DateTime lastDate = DateTime(2999);

  _HomeControllerBase();

  @observable
  bool showCurrency = false;

  @observable
  int pressedAttentionIndex = -1;

  @observable
  Color? color;

  @action
  initState() async {
    try {
      currency.text = "R\$ 10.000,00";
      bills.text = "0,00";
    } catch (e) {
      e;
    }
  }

  @action
  toogleCurrency() {
    showCurrency = !showCurrency;
  }

  @action
  toggleSelect(int index) {
    pressedAttentionIndex = index;
  }

  @action
  changeColor(String tipo) {
    tipo == "Receita" ? color = Colors.green : color = Colors.red;
  }

  @action
  Future datePicker(BuildContext context, String? day) async {
    if (day == "Hoje") {
      dateCtrl.text = toBRDt(DateTime.now());
    } else if (day == "Amanhã") {
      dateCtrl.text = toBRDt(DateTime.now().add(const Duration(hours: 24)));
    } else {
      final DateTime? datePicked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: firstDate,
        lastDate: lastDate,
        builder: (context, child) => Theme(
          data: ThemeData(timePickerTheme: Theme.of(context).timePickerTheme),
          child: child!,
        ),
      );

      if (datePicked != null && datePicked != selectedDate) {
        selectedDate = datePicked;
        dateCtrl.text = toBRDt(selectedDate);
      }
    }
  }

  @action
  toBRDt(DateTime? date) {
    if (date != null) {
      final day = date.day.toString();
      final month = date.month.toString();
      final year = date.year.toString();
      return "${day.padLeft(2, "0")}/${month.padLeft(2, "0")}/$year";
    }
    return "";
  }
}
