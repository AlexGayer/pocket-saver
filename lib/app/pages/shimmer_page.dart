import 'package:flutter/material.dart';
import 'package:flutter_pocket_saver/app/widgets/balance_widget.dart';
import 'package:flutter_pocket_saver/app/widgets/container_budget_widget.dart';
import 'package:flutter_pocket_saver/app/widgets/container_spending_widget.dart';
import 'package:flutter_pocket_saver/app/widgets/inc_exp_widget.dart';
import 'package:flutter_pocket_saver/app/widgets/user_widget.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerPage extends StatelessWidget {
  const ShimmerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.transparent,
      enabled: true,
      highlightColor: Colors.white,
      child: const SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserWidget(),
            BalanceWidget(),
            IncExpWidget(),
            ContainerSpendingWidget(),
            ContainerBudgetWidget(),
          ],
        ),
      ),
    );
  }
}
