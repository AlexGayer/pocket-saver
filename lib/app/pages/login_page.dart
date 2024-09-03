import 'package:flutter/material.dart';
import 'package:flutter_pocket_saver/app/controller/login_controller.dart';
import 'package:flutter_pocket_saver/app/global/widget/custom_app_bar_widget.dart';
import 'package:flutter_pocket_saver/app/global/widget/custom_elevated_button.dart';
import 'package:flutter_pocket_saver/app/global/widget/custom_text_button_widget.dart';

import 'package:flutter_pocket_saver/app/global/widget/custom_text_field_container.dart';
import 'package:flutter_pocket_saver/app/global/widget/stateful_widget.dart';
import 'package:flutter_pocket_saver/app/widgets/gradient_background_widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends WidgetStateful<LoginPage, LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarWidget(),
      body: GradientBackgroundWidget(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: controller.formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                      "Bem-vindo de volta!",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const SizedBox(height: 10),
                  CustomTextFieldContainer(
                    hintText: "Email",
                    pwd: false,
                    prefixIcon: MdiIcons.email,
                    focus: controller.focusEmail,
                    controller: controller.emailCtrl,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 20),
                  CustomTextFieldContainer(
                    pwd: true,
                    focus: controller.focusPwd,
                    controller: controller.pwdCtrl,
                    hintText: "Senha",
                    validatorText: "Informe sua senha !",
                    prefixIcon: MdiIcons.lock,
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 20),
                  CustomElevatedButton(
                    backgroundColor: const Color(0xFF0F052C),
                    text: "Acessar",
                    onPressed: () async {
                      controller.setFirstLogin(false);
                      controller.login(context);
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomTextButtonWidget(
                      funct: () => teste(),
                      title: "Esqueceu sua senha?",
                      color: Colors.white)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  teste() {
    return print("teste");
  }
}
