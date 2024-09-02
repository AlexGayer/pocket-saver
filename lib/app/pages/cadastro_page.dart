import 'package:flutter/material.dart';
import 'package:flutter_pocket_saver/app/controller/login_controller.dart';
import 'package:flutter_pocket_saver/app/global/widget/custom_text_field_container.dart';
import 'package:flutter_pocket_saver/app/global/widget/stateful_widget.dart';
import 'package:flutter_pocket_saver/app/widgets/gradient_background_widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends WidgetStateful<CadastroPage, LoginController> {
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
                  child: Text("Cadastro",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displayLarge)),
              const SizedBox(height: 10),
              CustomTextFieldContainer(
                focus: controller.focusName,
                controller: controller.nameCtrl,
                hintText: "Nome completo",
                validatorText: "Informe seu nome !",
                prefixIcon: MdiIcons.account,
              ),
              const SizedBox(height: 10),
              CustomTextFieldContainer(
                email: true,
                focus: controller.focusEmail,
                controller: controller.emailCtrl,
                hintText: "Email",
                validatorText: "Informe seu email !",
                prefixIcon: MdiIcons.email,
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
                      controller.setFirstLogin(true);
                      controller.login(context);
                    },
                    child: const Text("Cadastrar")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
