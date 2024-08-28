import 'package:flutter/material.dart';
import 'package:flutter_pocket_saver/app/constant/app_constants.dart';
import 'package:flutter_pocket_saver/app/contas/domain/model/contas.dart';
import 'package:flutter_pocket_saver/app/contas/domain/usecase/busca_contas_usecase.dart';
import 'package:flutter_pocket_saver/app/global/widget/custom_dialog_widget.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
part 'home_controller.g.dart';

@injectable
class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final BuscaContasUsecase _buscaContasUsecase;

  final currency = TextEditingController();
  final edtValor = TextEditingController();
  final edtData = TextEditingController();
  final edtDescr = TextEditingController();
  final billsNode = FocusNode();
  final mHandler = CustomDialogWidget();

  TimeOfDay timeOfDay = TimeOfDay.now();
  DateTime selectedDate = DateTime.now();
  DateTime firstDate = DateTime(2024);
  DateTime lastDate = DateTime(2999);

  _HomeControllerBase(this._buscaContasUsecase);

  @observable
  bool showCurrency = false;

  @observable
  int pressedAttentionIndex = -1;

  @observable
  Color? color;

  @observable
  List<Contas> _contas = <Contas>[];

  @computed
  List<Contas> get contas => _contas;

  @action
  initState() async {
    try {
      currency.text = "R\$ 10.000,00";
      edtValor.text = "0,00";
      _contas = await _buscaContasUsecase.fetchContas();
    } catch (e) {
      e;
    }
  }

  // despesas

  // @action
  // Future<void> buscaDespesas() async {
  //   try {
  //     final despesas = await _buscaDespesaUsecase.fetchDespesas();
  //     // Faça algo com as receitas, como atualizá-las na UI
  //   } catch (e) {
  //     // Trate o erro
  //   }
  // }

  @action
  Future<void> adicionaContas(String tipo) async {
    final id = DateTime.now().millisecondsSinceEpoch;
    final formatData = parseData(edtData.text);
    final formaValor = parseDouble(edtValor.text);

    final addContas = Contas(
      id: id,
      tipo: tipo,
      descricao: edtDescr.text,
      vencimento: formatData!,
      valor: formaValor,
    );

    // Mostra o Snackbar de carregamento
    ScaffoldMessenger.of(ctx).showSnackBar(
      const SnackBar(
        content: Text("Adicionando receita... Aguarde"),
        duration: Duration(seconds: 2), // Ajuste o tempo conforme necessário
      ),
    );

    try {
      // Adiciona a receita
      await _buscaContasUsecase.addContas(addContas);

      // Mostra o Snackbar de sucesso
      ScaffoldMessenger.of(ctx).showSnackBar(
        const SnackBar(
          content: Text("Receita gravada com sucesso!"),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      // Mostra o Snackbar de erro
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text("Ocorreu um erro ao gravar a receita: $e"),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  Future<void> deleteContas(int id) async {
    try {
      await _buscaContasUsecase.deleteContas(id);
      // Atualize a UI após a exclusão
    } catch (e) {
      // Trate o erro
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
      print('Invalid date format: $e');
      return null;
    }
  }

  @action
  double parseDouble(String input) {
    try {
      // Remove espaços em branco
      String value = input.trim();

      // Substitui vírgulas por pontos
      value = value.replaceAll(",", ".");

      // Remove pontos de milhar
      value = value.replaceAll(RegExp(r'(?<=\d)\.(?=\d{3})'), '');

      // Converte para double
      return double.parse(value);
    } catch (e) {
      // Lida com erros de formato
      throw FormatException('Formato inválido para número: $input');
    }
  }
}
