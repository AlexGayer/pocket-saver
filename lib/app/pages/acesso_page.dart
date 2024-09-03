import 'package:flutter/material.dart';
import 'package:flutter_pocket_saver/app/controller/login_controller.dart';
import 'package:flutter_pocket_saver/app/global/widget/custom_app_bar_widget.dart';
import 'package:flutter_pocket_saver/app/global/widget/custom_elevated_button.dart';
import 'package:flutter_pocket_saver/app/global/widget/custom_text_button_widget.dart';
import 'package:flutter_pocket_saver/app/global/widget/stateful_widget.dart';
import 'package:flutter_pocket_saver/app/widgets/gradient_background_widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AcessoPage extends StatefulWidget {
  final bool isLogin; // Indica se é a tela de login ou cadastro

  const AcessoPage({super.key, required this.isLogin});

  @override
  State<AcessoPage> createState() => _AcessoPageState();
}

class _AcessoPageState extends WidgetStateful<AcessoPage, LoginController> {
  @override
  Widget build(BuildContext context) {
    // Define textos e ações com base em isLogin
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
      appBar: const CustomAppBarWidget(),
      body: GradientBackgroundWidget(
        child: Form(
          key: controller.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 200,
                height: 200,
                child: Image.asset(
                  'assets/images/pocket_white.png',
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: Text(
                  pageTitle,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: double.infinity,
                child: Text(
                  pageSubtitle,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              const SizedBox(height: 20),
              CustomElevatedButton(
                backgroundColor: Colors.white,
                themeColor: Colors.black,
                text: "Continuar com Google",
                image: Image.asset(
                  'assets/images/google_icon.png',
                  fit: BoxFit.fill,
                  height: 30,
                ),
                onPressed: () async {
                  controller.setFirstLogin(!widget.isLogin);
                  controller.signInWithGoogle(context);
                },
              ),
              const SizedBox(height: 20),
              CustomElevatedButton(
                backgroundColor: const Color(0xFF0F052C),
                icon: MdiIcons.email,
                text: primaryButtonText,
                onPressed: primaryButtonAction,
              ),
              const SizedBox(height: 10),
              CustomTextButtonWidget(
                funct: () => Navigator.of(context).pushNamed(navigateRoute),
                title: secondaryButtonText,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
