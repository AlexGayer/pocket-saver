import 'package:flutter/material.dart';

const String indexRoute = "/index";
const String loginRoute = "/login";
const String cadastroRoute = "/cadastro";
const String homeRoute = "/home";
const String userRoute = "/user";
const String transactionsRoute = "/transactions";
const String despesasRoute = "/despesas";
const String receitasRoute = "/receitas";
const String analyticsRoute = "/analytics";

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final BuildContext ctx = navigatorKey.currentContext!;
