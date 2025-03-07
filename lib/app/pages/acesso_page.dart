import 'package:flutter/material.dart';
import 'package:flutter_pocket_saver/app/controller/login_controller.dart';
import 'package:flutter_pocket_saver/app/global/widget/custom_elevated_button.dart';
import 'package:flutter_pocket_saver/app/global/widget/custom_text_button_widget.dart';
import 'package:flutter_pocket_saver/app/global/widget/stateful_widget.dart';
import 'package:flutter_pocket_saver/app/widgets/gradient_background_widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'dart:ui';

class AcessoPage extends StatefulWidget {
  final bool isLogin;

  const AcessoPage({super.key, required this.isLogin});

  @override
  State<AcessoPage> createState() => _AcessoPageState();
}

class _AcessoPageState extends WidgetStateful<AcessoPage, LoginController>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.65, curve: Curves.easeOut),
      ),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.25), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.65, curve: Curves.easeOut),
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String pageTitle =
        widget.isLogin ? "Bem-vindo de volta!" : "Comece aqui!";
    final String pageSubtitle = widget.isLogin
        ? "Faça login para continuar controlando suas finanças!"
        : "Crie sua conta e inicie o controle de suas finanças!";
    final String primaryButtonText =
        widget.isLogin ? "Entrar com E-mail" : "Continuar com E-mail";
    final String secondaryButtonText = widget.isLogin
        ? "Não tem uma conta? Cadastre-se"
        : "Já tem uma conta? Entrar";
    final String navigateRoute = widget.isLogin ? "/login" : "/cadastro";
    final void Function() primaryButtonAction = widget.isLogin
        ? () => Navigator.of(context).pushNamed("/login")
        : () => Navigator.of(context).pushNamed(navigateRoute);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),
        ),
      ),
      body: GradientBackgroundWidget(
        child: SafeArea(
          child: Form(
            key: controller.formKey,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: SlideTransition(
                  position: _slideAnimation,
                  child: FadeTransition(
                    opacity: _fadeInAnimation,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 40),
                        Hero(
                          tag: 'logo',
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  blurRadius: 25,
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
                            child: Image.asset(
                              'assets/images/pocket_white.png',
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                        Text(
                          pageTitle,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                letterSpacing: -0.5,
                              ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          pageSubtitle,
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Colors.white.withValues(alpha: 0.8),
                                    letterSpacing: 0.2,
                                  ),
                        ),
                        const SizedBox(height: 60),
                        _buildSocialLoginButton(
                          icon: 'assets/images/google_icon.png',
                          text: "Continuar com Google",
                          onPressed: () async {
                            controller.setFirstLogin(!widget.isLogin);
                            controller.signInWithGoogle(context);
                          },
                        ),
                        const SizedBox(height: 16),
                        CustomElevatedButton(
                          backgroundColor: Colors.transparent,
                          borderColor: Colors.white.withValues(alpha: 0.3),
                          icon: MdiIcons.email,
                          text: primaryButtonText,
                          onPressed: primaryButtonAction,
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: Colors.white.withValues(alpha: 0.3),
                                thickness: 0.5,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(
                                "ou",
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.7),
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: Colors.white.withValues(alpha: 0.3),
                                thickness: 0.5,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        CustomTextButtonWidget(
                          funct: () =>
                              Navigator.of(context).pushNamed(navigateRoute),
                          title: secondaryButtonText,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialLoginButton({
    required String icon,
    required String text,
    required VoidCallback onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: CustomElevatedButton(
        backgroundColor: Colors.white,
        themeColor: Colors.black,
        text: text,
        image: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Image.asset(
            icon,
            fit: BoxFit.contain,
            height: 24,
          ),
        ),
        onPressed: onPressed,
        textStyle: const TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    );
  }
}
