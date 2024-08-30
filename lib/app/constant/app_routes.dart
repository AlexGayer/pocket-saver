import 'package:flutter/material.dart';
import 'package:flutter_pocket_saver/app/pages/analytics_page.dart';
import 'package:flutter_pocket_saver/app/pages/user_page.dart';
import 'package:flutter_pocket_saver/app/constant/app_constants.dart';
import 'package:flutter_pocket_saver/app/pages/despesas_page.dart';
import 'package:flutter_pocket_saver/app/pages/receitas_page.dart';
import 'package:flutter_pocket_saver/app/pages/home_page.dart';
import 'package:flutter_pocket_saver/app/pages/index_page.dart';
import 'package:flutter_pocket_saver/app/pages/transactions_page.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case indexRoute:
        return SlideRightRoute(widget: const IndexPage());
      case homeRoute:
        return SlideRightRoute(widget: const HomePage());
      case transactionsRoute:
        return SlideRightRoute(widget: const TransactionsPage());
      case despesasRoute:
        return SlideRightRoute(widget: const DespesasPage());
      case receitasRoute:
        return SlideRightRoute(widget: const ReceitasPage());
      case analyticsRoute:
        return SlideRightRoute(widget: const AnalyticsPage());
      case userRoute:
        return SlideRightRoute(widget: const UserPage());

      default:
        return SlideRightRoute(widget: const IndexPage());
    }
  }
}

class SlideRightRoute extends PageRouteBuilder {
  final Widget widget;
  SlideRightRoute({required this.widget})
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return widget;
          },
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
          transitionDuration: const Duration(milliseconds: 500),
        );
}
