// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, avoid_print

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
  bool _loading = false;

  @observable
  double totalReceitas = 0.0;

  @observable
  double totalDespesas = 0.0;

  @observable
  double totalContas = 0.0;

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

  @computed
  bool get loading => _loading;

  @action
  initState() async {
    try {
      edtValor.text = "0,00";
      _loading = false;
    } catch (e) {
      _loading = false;
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
  Future<void> fetchContas() async {
    try {
      List<Contas> despesas = await _buscaContasUsecase.fetchContas('Despesa');

      List<Contas> receitas = await _buscaContasUsecase.fetchContas('Receita');

      contas = [...despesas, ...receitas];
    } catch (e) {
      print('Erro ao buscar contas: $e');
    }
  }

  @action
  Future<void> fetchAndCalculateTotals() async {
    _loading = true;
    try {
      final List<Contas> receitas =
          await _buscaContasUsecase.fetchContas('Receita');
      final List<Contas> despesas =
          await _buscaContasUsecase.fetchContas('Despesa');

      totalReceitas = receitas.fold(0, (sum, item) => sum + item.valor);
      totalDespesas = despesas.fold(0, (sum, item) => sum + item.valor);

      // Calcular o total geral
      totalContas = totalReceitas - totalDespesas;

      // Atualizar o TextEditingController
      _updateTotalContasController();

      // print('Total Receitas: $totalReceitas');
      // print('Total Despesas: $totalDespesas');
      // print('Total Contas: $totalContas');
      _loading = false;
    } catch (e) {
      _loading = false;
      print('Erro ao calcular os totais: $e');
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
      await fetchAndCalculateTotals();
    } catch (e) {
      showCustomSnackBar(ctx, "Ocorreu um erro ao gravar a $tipo: $e");
    }
  }

  @action
  Future<void> deleteContas(int id, String tipo) async {
    try {
      await _buscaContasUsecase.deleteContas(id);
      showCustomSnackBar(ctx, "$tipo excluída com sucesso com sucesso!");
      await fetchAndCalculateTotals();
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
  Future datePicker(BuildContext context, String? date) async {
    if (date == "Hoje") {
      edtData.text = toBRDt(DateTime.now());
    } else if (date == "Amanhã") {
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
  setColor(String tipo) {
    tipo == "Receita" ? color = Colors.green : color = Colors.red;
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

  String formatDouble(double value, {String? locale, String? pattern}) {
    try {
      final format = NumberFormat(pattern ?? 'R\$ #,##0.##', locale ?? 'pt_BR');
      return format.format(value);
    } catch (e) {
      return 'Invalid value';
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
  void _updateTotalContasController() {
    currency.text = formatCurrency(totalContas);
  }

  String formatCurrency(double value) {
    final format = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    return format.format(value);
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
