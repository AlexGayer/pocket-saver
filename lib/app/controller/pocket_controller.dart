// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_pocket_saver/app/constant/app_constants.dart';
import 'package:flutter_pocket_saver/app/domain/model/contas.dart';
import 'package:flutter_pocket_saver/app/domain/usecase/busca_contas_usecase.dart';
import 'package:flutter_pocket_saver/app/global/widget/custom_dialog_widget.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
part 'pocket_controller.g.dart';

@injectable
class PocketController = _PocketControllerBase with _$PocketController;

abstract class _PocketControllerBase with Store {
  final BuscaContasUsecase _buscaContasUsecase;

  final currency = TextEditingController();
  final edtValor = TextEditingController();
  final edtData = TextEditingController();
  final edtDescr = TextEditingController();
  final mHandler = CustomDialogWidget();

  TimeOfDay timeOfDay = TimeOfDay.now();
  DateTime selectedDate = DateTime.now();
  DateTime firstDate = DateTime(2024);
  DateTime lastDate = DateTime(2999);

  _PocketControllerBase(this._buscaContasUsecase);

  @observable
  bool showCurrency = false;

  @observable
  int pressedAttentionIndex = -1;

  @observable
  Color? color;

  @observable
  String edtCat = "";

  @observable
  List<Contas> contas = [];

  @observable
  List<String> categorias = [
    "Casa",
    "Educação",
    "Alimentação",
    "Lazer",
    "Saúde",
    "Transporte",
    "Roupas",
    "Entretenimento",
    "Outros"
  ];

  @action
  initState() async {
    try {
      currency.text = "R\$ 10.000,00";
      edtValor.text = "0,00";
    } catch (e) {
      e;
    }
  }

  @action
  Future<void> fetchContasByTipo(String tipo) async {
    try {
      List<Contas> allContas = await _buscaContasUsecase.fetchContas(tipo);
      contas = allContas;
    } catch (e) {
      print('Erro ao buscar contas por tipo: $e');
    }
  }

  @action
  Future<void> adicionaContas(String tipo, String categoria) async {
    final id = DateTime.now().millisecondsSinceEpoch;
    final formatData = parseData(edtData.text);
    final formaValor = parseDouble(edtValor.text);

    final addContas = Contas(
      id: id,
      tipo: tipo,
      descricao: edtDescr.text,
      categoria: categoria,
      vencimento: formatData!,
      valor: formaValor,
    );

    showCustomSnackBar(ctx, "Adicionando $tipo... Aguarde");

    try {
      await _buscaContasUsecase.addContas(addContas);

      showCustomSnackBar(ctx, "$tipo gravada com sucesso!");
    } catch (e) {
      showCustomSnackBar(ctx, "Ocorreu um erro ao gravar a $tipo: $e");
    }
  }

  Future<void> deleteContas(int id, String tipo) async {
    try {
      await _buscaContasUsecase.deleteContas(id);
      showCustomSnackBar(ctx, "$tipo excluída com sucesso com sucesso!");
    } catch (e) {
      showCustomSnackBar(ctx, "Ocorreu um erro ao excluir a $tipo: $e");
    }
  }

  @action
  Future<void> atualizarContas(Contas contas) async {
    try {
      await _buscaContasUsecase.updateContas(contas);
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
      edtData.text = toBRDt(DateTime.now());
    } else if (day == "Amanhã") {
      edtData.text = toBRDt(DateTime.now().add(const Duration(hours: 24)));
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
        edtData.text = toBRDt(selectedDate);
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

  @action
  DateTime? parseData(String data) {
    try {
      final inputFormat = DateFormat('dd/MM/yyyy');
      return inputFormat.parse(data);
    } catch (e) {
      return null;
    }
  }

  @action
  double parseDouble(String input) {
    try {
      String value = input.trim();

      value = value.replaceAll(",", ".");

      value = value.replaceAll(RegExp(r'(?<=\d)\.(?=\d{3})'), '');

      return double.parse(value);
    } catch (e) {
      throw FormatException('Formato inválido para número: $input');
    }
  }

  @action
  void showCustomSnackBar(BuildContext context, String message,
      {Duration duration = const Duration(seconds: 3)}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
      ),
    );
  }
}