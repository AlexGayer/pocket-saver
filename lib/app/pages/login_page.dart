import 'package:flutter/material.dart';
import 'package:flutter_pocket_saver/app/controller/login_controller.dart';
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
      body: GradientBackgroundWidget(
        child: Form(
          key: controller.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  width: 300,
                  child: Text("Login",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displayLarge)),
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
              const SizedBox(height: 10),
              CustomTextFieldContainer(
                pwd: true,
                focus: controller.focusPwd,
                controller: controller.pwdCtrl,
                hintText: "Senha",
                validatorText: "Informe sua senha !",
                prefixIcon: MdiIcons.lock,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0F052C),
                    ),
                    onPressed: () async {
                      controller.setFirstLogin(false);
                      controller.login(context);
                    },
                    child: const Text("Acessar")),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    child: const Text("Não tem uma conta? Cadastre aqui",
                        textAlign: TextAlign.end),
                    onPressed: () =>
                        Navigator.of(context).pushNamed("/cadastro"),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              const Text("Acessar com",
                  style: TextStyle(color: Colors.grey, fontSize: 20)),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 50,
                    width: 200,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(30))),
                      onPressed: () async =>
                          await controller.signInWithGoogle(),
                      label: Text(
                        "Google",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      icon: Image.asset(
                        'assets/images/google_icon.png',
                        fit: BoxFit.fill,
                        height: 30,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 50,
                    width: 200,
                    child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                                side: const BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(30))),
                        onPressed: () {},
                        label: Text(
                          "Apple",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        icon: Icon(
                          MdiIcons.apple,
                          color: Colors.white,
                          size: 30,
                        )),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
