import 'package:flutter/material.dart';
import 'package:flutter_pocket_saver/app/pages/analytics_page.dart';
import 'package:flutter_pocket_saver/app/pages/user_page.dart';
import 'package:flutter_pocket_saver/app/global/widget/custom_tab_bar_widget.dart';
import 'package:flutter_pocket_saver/app/pages/home_page.dart';
import 'package:flutter_pocket_saver/app/pages/transactions_page.dart';

class PocketPage extends StatefulWidget {
  const PocketPage({super.key});

  @override
  State<PocketPage> createState() => _PocketPageState();
}

class _PocketPageState extends State<PocketPage>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late TabController _tabController;

  // Lista de telas disponíveis (sem o botão central "Adicionar")
  final List<Widget> _screens = [
    const HomePage(),
    const TransactionsPage(),
    const AnalyticsPage(),
    const UserPage(),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _screens.length, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {
          _currentIndex = _tabController.index;
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onTap(int index) {
    // O índice já está mapeado corretamente pelo CustomTabBarWidget
    setState(() {
      _currentIndex = index;
      _tabController.animateTo(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody:
          true, // Permite que o conteúdo se estenda atrás da barra de navegação
      body: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: _screens,
      ),
      bottomNavigationBar: CustomTabBarWidget(
        currentIndex: _currentIndex,
        onTap: _onTap,
      ),
    );
  }
}
