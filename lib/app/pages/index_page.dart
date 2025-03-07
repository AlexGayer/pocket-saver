import 'package:flutter/material.dart';
import 'package:flutter_pocket_saver/app/global/widget/custom_elevated_button.dart';
import 'package:flutter_pocket_saver/app/widgets/gradient_background_widget.dart';
import 'package:flutter_pocket_saver/app/pages/acesso_page.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fadeInAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
      ),
    );

    _scaleAnimation = Tween<double>(
      begin: 0.85,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.1, 0.8, curve: Curves.easeOutCubic),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.2, 0.8, curve: Curves.easeOut),
      ),
    );

    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        _animationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: GradientBackgroundWidget(
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              height: screenSize.height - MediaQuery.of(context).padding.top,
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(flex: 1),
                  ScaleTransition(
                    scale: _scaleAnimation,
                    child: FadeTransition(
                      opacity: _fadeInAnimation,
                      child: Hero(
                        tag: 'logo',
                        child: Container(
                          width: 180,
                          height: 180,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withValues(alpha: 0.2),
                                blurRadius: 30,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: Image.asset(
                            'assets/images/pocket_white.png',
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  SlideTransition(
                    position: _slideAnimation,
                    child: FadeTransition(
                      opacity: _fadeInAnimation,
                      child: Column(
                        children: [
                          Text(
                            "Pocket Saver",
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: 1.2,
                                ),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              "Controle suas finanças pessoais de maneira fácil e intuitiva",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    color: Colors.white.withValues(alpha: 0.9),
                                    height: 1.4,
                                    letterSpacing: 0.2,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 60),
                          _buildButton(
                            text: "Criar uma conta",
                            isPrimary: true,
                            onPressed: () {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      const AcessoPage(isLogin: false),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    const begin = Offset(1.0, 0.0);
                                    const end = Offset.zero;
                                    const curve = Curves.easeInOut;
                                    var tween = Tween(begin: begin, end: end)
                                        .chain(CurveTween(curve: curve));
                                    return SlideTransition(
                                      position: animation.drive(tween),
                                      child: child,
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 16),
                          _buildButton(
                            text: "Já tenho uma conta",
                            isPrimary: false,
                            onPressed: () {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      const AcessoPage(isLogin: true),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    const begin = Offset(1.0, 0.0);
                                    const end = Offset.zero;
                                    const curve = Curves.easeInOut;
                                    var tween = Tween(begin: begin, end: end)
                                        .chain(CurveTween(curve: curve));
                                    return SlideTransition(
                                      position: animation.drive(tween),
                                      child: child,
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(flex: 2),
                  FadeTransition(
                    opacity: _fadeInAnimation,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 24.0),
                      child: Text(
                        "Versão 1.0.0",
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.6),
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton({
    required String text,
    required bool isPrimary,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: double.infinity,
      decoration: isPrimary
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF0F052C).withValues(alpha: 0.3),
                  blurRadius: 15,
                  spreadRadius: 0,
                  offset: const Offset(0, 5),
                ),
              ],
            )
          : null,
      child: isPrimary
          ? CustomElevatedButton(
              backgroundColor: Colors.white,
              themeColor: const Color(0xFF0F052C),
              text: text,
              textStyle: const TextStyle(
                color: Color(0xFF0F052C),
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              onPressed: onPressed,
            )
          : CustomElevatedButton(
              backgroundColor: Colors.transparent,
              borderColor: Colors.white.withValues(alpha: 0.3),
              text: text,
              textStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              onPressed: onPressed,
            ),
    );
  }
}
