import 'package:flutter/material.dart';
import 'package:flutter_pocket_saver/app/despesa/domain/model/despesa.dart';
import 'package:flutter_pocket_saver/app/despesa/domain/usecase/busca_despesa_usecase.dart';
import 'package:flutter_pocket_saver/app/receita/domain/model/receita.dart';
import 'package:flutter_pocket_saver/app/receita/domain/usecase/busca_receita_usecase.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
part 'home_controller.g.dart';

@injectable
class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final BuscaDespesaUsecase _buscaDespesaUsecase;
  final BuscaReceitaUsecase _buscaReceitaUsecase;

  final currency = TextEditingController();
  final edtValor = TextEditingController();
  final edtData = TextEditingController();
  final edtDescr = TextEditingController();
  final billsNode = FocusNode();

  TimeOfDay timeOfDay = TimeOfDay.now();
  DateTime selectedDate = DateTime.now();
  DateTime firstDate = DateTime(2024);
  DateTime lastDate = DateTime(2999);

  _HomeControllerBase(this._buscaDespesaUsecase, this._buscaReceitaUsecase);

  @observable
  bool showCurrency = false;

  @observable
  int pressedAttentionIndex = -1;

  @observable
  Color? color;

  @observable
  List<Receita> _receita = <Receita>[];

  @observable
  List<Despesa> _despesa = <Despesa>[];

  @computed
  List<Receita> get receita => _receita;

  @computed
  List<Despesa> get despesa => _despesa;

  @action
  initState() async {
    try {
      currency.text = "R\$ 10.000,00";
      edtValor.text = "0,00";
      _receita = await _buscaReceitaUsecase.fetchReceitas();
      _despesa = await _buscaDespesaUsecase.fetchDespesas();
    } catch (e) {
      e;
    }
  }

  // receitas
  // @action
  // Future<void> buscaReceita() async {
  //   try {
  //     final receitas = await _buscaReceitaUsecase.fetchReceitas();
  //   } catch (e) {
  //     e;
  //   }
  // }

  @action
  Future<void> adicionaReceita(String tipo) async {
    final id = DateTime.now().millisecondsSinceEpoch;
    final formatData = parseData(edtData.text);
    final formaValor = double.parse(edtValor.text.replaceAll(",", "."));

    final addReceita = Receita(
      id: id,
      tipo: tipo,
      descricao: edtDescr.text,
      vencimento: formatData!,
      valor: formaValor,
    );

    try {
      await _buscaReceitaUsecase.addReceita(addReceita);
    } catch (e) {
      e;
    }
  }

  Future<void> deleteReceita(int id) async {
    try {
      await _buscaReceitaUsecase.deleteReceita(id);
      // Atualize a UI após a exclusão
    } catch (e) {
      // Trate o erro
    }
  }

  @action
  Future<void> atualizarReceita(Receita receita) async {
    try {
      await _buscaReceitaUsecase.updateReceita(receita);
      // Atualize a UI após a atualização
    } catch (e) {
      // Trate o erro
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
  Future<void> adicionaDespesa(String tipo) async {
    final id = DateTime.now().millisecondsSinceEpoch;
    final formatData = parseData(edtData.text);
    final formaValor = double.parse(edtValor.text.replaceAll(",", "."));

    final addDespesa = Despesa(
      id: id,
      tipo: tipo,
      descricao: edtDescr.text,
      vencimento: formatData!,
      valor: formaValor,
    );

    try {
      await _buscaDespesaUsecase.addDespesa(addDespesa);
    } catch (e) {
      e;
    }
  }

  Future<void> deleteDespesa(int id) async {
    try {
      await _buscaDespesaUsecase.deleteDespesa(id);
      // Atualize a UI após a exclusão
    } catch (e) {
      // Trate o erro
    }
  }

  @action
  Future<void> atualizarDespesa(Despesa despesa) async {
    try {
      await _buscaDespesaUsecase.updateDespesa(despesa);
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
}
