import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_pocket_saver/app/global/widget/stateful_widget.dart';
import 'package:flutter_pocket_saver/app/pages/shimmer_page.dart';
import 'package:flutter_pocket_saver/app/widgets/balance_widget.dart';
import 'package:flutter_pocket_saver/app/widgets/container_budget_widget.dart';
import 'package:flutter_pocket_saver/app/widgets/container_spending_widget.dart';
import 'package:flutter_pocket_saver/app/widgets/gradient_background_widget.dart';
import 'package:flutter_pocket_saver/app/widgets/inc_exp_widget.dart';
import 'package:flutter_pocket_saver/app/widgets/monthly_chart_widget.dart';
import 'package:flutter_pocket_saver/app/widgets/user_widget.dart';
import 'package:flutter_pocket_saver/app/controller/pocket_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends WidgetStateful<HomePage, PocketController>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    controller.initState();
    controller.fetchAndCalculateTotals();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    controller.fetchAndCalculateTotals();

    final bool? shouldUpdate =
        ModalRoute.of(context)?.settings.arguments as bool?;
    if (shouldUpdate == true) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackgroundWidget(
        child: SafeArea(
          child: Observer(
            builder: (_) => controller.loading
                ? const ShimmerPage()
                : RefreshIndicator(
                    onRefresh: () async {
                      await controller.fetchAndCalculateTotals();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 16),
                            const UserWidget(),
                            const SizedBox(height: 16),
                            const BalanceWidget(),
                            const SizedBox(height: 16),
                            const IncExpWidget(),
                            const SizedBox(height: 24),
                            MonthlyChartWidget(controller: controller),
                            const SizedBox(height: 24),
                            const ContainerSpendingWidget(),
                            const SizedBox(height: 24),
                            const ContainerBudgetWidget(),
                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
