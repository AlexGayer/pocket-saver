import 'package:flutter/material.dart';
import 'package:flutter_pocket_saver/app/analytics/widget/analytics_page.dart';
import 'package:flutter_pocket_saver/app/config/view/config_page.dart';
import 'package:flutter_pocket_saver/app/global/widget/custom_botton_navigation.dart';
import 'package:flutter_pocket_saver/app/home/widget/home_page.dart';
import 'package:flutter_pocket_saver/app/payments/view/payments_page.dart';

class NavigatorPage extends StatefulWidget {
  const NavigatorPage({super.key});

  @override
  State<NavigatorPage> createState() => _NavigatorPageState();
}

class _NavigatorPageState extends State<NavigatorPage> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomePage(),
    const PaymentsPage(),
    const AnalyticsPage(),
    const ConfigPage(),
  ];

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black54,
            Colors.black87,
            Colors.black,
            Colors.black,
          ],
        )),
        child: SafeArea(
          child: IndexedStack(
            index: _currentIndex,
            children: _screens,
          ),
        ),
      ),
      bottomNavigationBar: CustomBottonNavigation(
        currentIndex: _currentIndex,
        onTap: _onTap,
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () => _addCount(),
        backgroundColor: Colors.lime,
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void _addCount() {
    showDialog(
      context: context,
      builder: (context) => const AlertDialog(
        title: Text("Testee"),
      ),
    );
  }
}
