import 'package:flutter/material.dart';
import 'package:flutter_pocket_saver/app/analytics/widget/analytics_page.dart';
import 'package:flutter_pocket_saver/app/config/view/config_page.dart';
import 'package:flutter_pocket_saver/app/constant/app_constants.dart';
import 'package:flutter_pocket_saver/app/expenses/view/expenses_page.dart';
import 'package:flutter_pocket_saver/app/home/widget/home_page.dart';
import 'package:flutter_pocket_saver/app/incomes/view/incomes_page.dart';
import 'package:flutter_pocket_saver/app/index/page/index_page.dart';
import 'package:flutter_pocket_saver/app/transactions/view/transactions_page.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case indexRoute:
        return SlideRightRoute(widget: const IndexPage());
      case homeRoute:
        return SlideRightRoute(widget: const HomePage());
      case transactionsRoute:
        return SlideRightRoute(widget: const TransactionsPage());
      case incomesRoute:
        return SlideRightRoute(widget: const IncomesPage());
      case expensesRoute:
        return SlideRightRoute(widget: const ExpensesPage());
      case analyticsRoute:
        return SlideRightRoute(widget: const AnalyticsPage());
      case configRoute:
        return SlideRightRoute(widget: const ConfigPage());

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
