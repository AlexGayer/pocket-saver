import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_pocket_saver/app/pages/analytics_page.dart';
import 'package:flutter_pocket_saver/app/pages/user_page.dart';
import 'package:flutter_pocket_saver/app/global/widget/custom_fab_widget.dart';
import 'package:flutter_pocket_saver/app/global/widget/custom_tab_bar_widget.dart';
import 'package:flutter_pocket_saver/app/pages/home_page.dart';
import 'package:flutter_pocket_saver/app/pages/transactions_page.dart';

class PocketPage extends StatefulWidget {
  const PocketPage({super.key});

  @override
  State<PocketPage> createState() => _PocketPageState();
}

class _PocketPageState extends State<PocketPage> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomePage(),
    const TransactionsPage(),
    const AnalyticsPage(),
    const UserPage(),
  ];

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _screens.length,
      initialIndex: _currentIndex,
      child: Scaffold(
        body: SafeArea(
          child: TabBarView(
            clipBehavior: Clip.antiAlias,
            children: _screens,
          ),
        ),
        bottomNavigationBar: CustomTabBarWidget(
          currentIndex: _currentIndex,
          onTap: _onTap,
        ),
        floatingActionButton: _currentIndex == 0
            ? const CustomFabWidget()
            : const SizedBox.shrink(),
        persistentFooterAlignment: AlignmentDirectional.bottomCenter,
        floatingActionButtonLocation: ExpandableFab.location,
      ),
    );
  }
}
