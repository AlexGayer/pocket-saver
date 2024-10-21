// ignore_for_file: library_private_types_in_public_api, avoid_print, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pocket_saver/app/constant/app_constants.dart';
import 'package:flutter_pocket_saver/app/constant/app_shared_preferences.dart';
import 'package:flutter_pocket_saver/app/domain/model/categoria.dart';
import 'package:flutter_pocket_saver/app/domain/model/contas.dart';
import 'package:flutter_pocket_saver/app/domain/usecase/busca_contas_usecase.dart';
import 'package:flutter_pocket_saver/app/constant/dialog_helper.dart';
import 'package:flutter_pocket_saver/app/domain/usecase/firebase_usecase.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';

part 'pocket_controller.g.dart';

@injectable
class PocketController = _PocketControllerBase with _$PocketController;

abstract class _PocketControllerBase with Store {
  final BuscaContasUsecase _buscaContasUsecase;
  final FirebaseUsecase _firebaseUsecase;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final currency = TextEditingController();
  final edtValor = TextEditingController();
  final edtVcto = TextEditingController();
  final edtCdto = TextEditingController();
  final edtDescr = TextEditingController();
  final mHandler = DialogHelper();
  final sHandler = AppSharedPreferences();

  TimeOfDay timeOfDay = TimeOfDay.now();
  DateTime selectedDate = DateTime.now();
  DateTime firstDate = DateTime(2024);
  DateTime lastDate = DateTime(2999);

  _PocketControllerBase(this._buscaContasUsecase, this._firebaseUsecase);

  @observable
  String userName = "";

  @observable
  String userPhotoURL = "";

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
  List<String> categorias = [];

  @computed
  bool get loading => _loading;

  @action
  Future<void> initState() async {
    try {
      edtValor.text = "0,00";
      _loading = false;

      final userId = _auth.currentUser?.uid;
      if (userId != null) {
        final userDetails = await _firebaseUsecase.getUserDetails(userId);
        if (userDetails != null) {
          userName = userDetails.name;
          userPhotoURL = userDetails.photoURL ?? "";
        }
      }
    } catch (e) {
      _loading = false;
      print('Erro ao inicializar estado: $e');
    }
  }

  @action
  Future<void> fetchContasByTipo(String tipo) async {
    final userId = _auth.currentUser?.uid;
    try {
      List<Contas> allContas =
          await _buscaContasUsecase.fetchContasByTipo(userId!, tipo);
      contas = allContas;
    } catch (e) {
      print('Erro ao buscar contas por tipo: $e');
    }
  }

  @action
  Future<void> fetchContas() async {
    final userId = _auth.currentUser?.uid;
    try {
      contas = await _buscaContasUsecase.fetchContas(userId!);
    } catch (e) {
      print('Erro ao buscar contas: $e');
    }
  }

  @action
  Future<void> fetchAndCalculateTotals() async {
    _loading = true;
    final userId = _auth.currentUser?.uid;
    try {
      final List<Contas> receitas =
          await _buscaContasUsecase.fetchContasByTipo(userId!, 'Receita');
      final List<Contas> despesas =
          await _buscaContasUsecase.fetchContasByTipo(userId, 'Despesa');

      totalReceitas = receitas.fold(0, (sum, item) => sum + item.valor);
      totalDespesas = despesas.fold(0, (sum, item) => sum + item.valor);

      totalContas = totalReceitas - totalDespesas;

      _updateTotalContasController();

      _loading = false;
    } catch (e) {
      _loading = false;
      print('Erro ao calcular os totais: $e');
    }
  }

  @action
  Future<void> adicionaContas(String tipo, String categoria) async {
    final id = DateTime.now().millisecondsSinceEpoch;
    final formatVcto = parseData(edtVcto.text);
    final formatCdto = DateTime.now();
    final formaValor = parseDouble(edtValor.text);

    final addContas = Contas(
      id: id,
      tipo: tipo,
      descricao: edtDescr.text,
      categoria: categoria,
      dtVencimento: formatVcto!,
      dtCadastro: formatCdto,
      valor: formaValor,
    );

    try {
      final userId = _auth.currentUser?.uid;
      await _buscaContasUsecase.addContas(userId!, addContas);

      showCustomSnackBar(ctx, "$tipo gravada com sucesso!");
      await fetchAndCalculateTotals();
    } catch (e) {
      showCustomSnackBar(ctx, "Ocorreu um erro ao gravar a $tipo: $e");
    }
  }

  @action
  Future<void> deleteContas(int id, String tipo) async {
    final userId = _auth.currentUser?.uid;
    try {
      await _buscaContasUsecase.deleteContas(userId!, id);
      showCustomSnackBar(ctx, "$tipo excluída com sucesso com sucesso!");
      await fetchAndCalculateTotals();
    } catch (e) {
      showCustomSnackBar(ctx, "Ocorreu um erro ao excluir a $tipo: $e");
    }
  }

  @action
  Future<void> atualizarContas(Contas contas) async {
    final userId = _auth.currentUser?.uid;
    try {
      await _buscaContasUsecase.updateContas(userId!, contas);
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
      edtVcto.text = toBRDt(DateTime.now());
    } else if (date == "Amanhã") {
      edtVcto.text = toBRDt(DateTime.now().add(const Duration(hours: 24)));
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
        edtVcto.text = toBRDt(selectedDate);
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

  @action
  String formatDouble(double value, {String? locale, String? pattern}) {
    try {
      final format = NumberFormat(pattern ?? 'R\$ #,##0.##', locale ?? 'pt_BR');
      return format.format(value);
    } catch (e) {
      return 'Invalid value';
    }
  }

  @action
  double parseDouble(String valor) {
    try {
      final currencyFormat = NumberFormat.simpleCurrency(locale: 'pt_BR');
      return currencyFormat.parse(valor).toDouble();
    } catch (e) {
      return 0.0;
    }
  }

  @action
  _updateTotalContasController() {
    edtValor.text = NumberFormat.currency(locale: 'pt_BR').format(totalContas);
  }

  @action
  showCustomSnackBar(BuildContext ctx, String message) {
    ScaffoldMessenger.of(ctx).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @action
  Future<Map<String, double>> agruparContasPorCategoria() async {
    await fetchContas();

    Map<String, double> categoriasTotais = {};

    for (var conta in contas) {
      if (categoriasTotais.containsKey(conta.categoria)) {
        categoriasTotais[conta.categoria] =
            categoriasTotais[conta.categoria]! + conta.valor;
      } else {
        categoriasTotais[conta.categoria] = conta.valor;
      }
    }

    return categoriasTotais;
  }

  @action
  void adicionarCategoria(String nome) {
    final novaCategoria = Categoria(nome: nome);
    categorias = List.from(categorias)..add(novaCategoria.nome);
    addCategoria(nome);
  }

  @action
  Future<void> addCategoria(String nome) async {
    if (nome.isNotEmpty) {
      Categoria novaCategoria = Categoria(nome: nome);

      await _firebaseUsecase.addCategoria(novaCategoria);

      categorias.add(nome);
    } else {
      print("Nome da categoria não pode estar vazio.");
    }
  }

  @action
  Future<void> fetchCategorias() async {
    try {
      final List<Categoria> categoriasObtidas =
          await _firebaseUsecase.getCategorias();
      categorias =
          categoriasObtidas.map((categoria) => categoria.nome).toList();
    } catch (e) {
      print('Erro ao buscar categorias: $e');
    }
  }
}
