import 'package:flutter/material.dart';

const String indexRoute = "/index";
const String homeRoute = "/home";
const String configRoute = "/config";
const String transactionsRoute = "/transactions";
const String incomesRoute = "/incomes";
const String expensesRoute = "/expenses";
const String analyticsRoute = "/analytics";

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final BuildContext ctx = navigatorKey.currentContext!;
