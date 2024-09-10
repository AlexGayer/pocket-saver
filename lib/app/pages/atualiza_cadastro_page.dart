import 'package:flutter/material.dart';
import 'package:flutter_pocket_saver/app/controller/login_controller.dart';
import 'package:flutter_pocket_saver/app/global/widget/custom_app_bar_widget.dart';
import 'package:flutter_pocket_saver/app/global/widget/custom_elevated_button.dart';
import 'package:flutter_pocket_saver/app/global/widget/custom_text_field_container.dart';
import 'package:flutter_pocket_saver/app/global/widget/stateful_widget.dart';
import 'package:flutter_pocket_saver/app/widgets/gradient_background_widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AtualizaCadastroPage extends StatefulWidget {
  const AtualizaCadastroPage({super.key});

  @override
  State<AtualizaCadastroPage> createState() => _AtualizaCadastroPageState();
}

class _AtualizaCadastroPageState
    extends WidgetStateful<AtualizaCadastroPage, LoginController> {
  @override
  void initState() {
    controller.initState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarWidget(
        title: "Meus dados",
      ),
      body: GradientBackgroundWidget(
        child: Center(
          child: Form(
            key: controller.formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  CustomTextFieldContainer(
                    desableDecoration: true,
                    controller: controller.nameCtrl,
                    hintText: "Nome completo",
                    validatorText: "Informe seu nome!",
                    prefixIcon: MdiIcons.account,
                  ),
                  CustomTextFieldContainer(
                    desableDecoration: true,
                    email: true,
                    controller: controller.emailCtrl,
                    hintText: "Email",
                    validatorText: "Informe seu email!",
                    prefixIcon: MdiIcons.email,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  CustomTextFieldContainer(
                    desableDecoration: true,
                    cpf: true,
                    email: false,
                    controller: controller.cpfCtrl,
                    hintText: "CPF",
                    validatorText: "Informe seu CPF!",
                    prefixIcon: MdiIcons.email,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  GestureDetector(
                    onTap: () => controller.datePicker(context),
                    child: AbsorbPointer(
                      child: CustomTextFieldContainer(
                        desableDecoration: true,
                        controller: controller.birthCtrl,
                        hintText: "Data Nascimento",
                        validatorText: "Informe sua data de nascimento!",
                        prefixIcon: MdiIcons.calendar,
                        keyboardType: TextInputType.datetime,
                      ),
                    ),
                  ),
                  CustomTextFieldContainer(
                    phone: true,
                    desableDecoration: true,
                    controller: controller.phoneCtrl,
                    hintText: "Telefone",
                    validatorText: "Informe seu telefone!",
                    prefixIcon: MdiIcons.phone,
                    keyboardType: TextInputType.phone,
                  ),
                  CustomTextFieldContainer(
                    desableDecoration: true,
                    controller: controller.cepCtrl,
                    hintText: "CEP",
                    validatorText: "Informe seu CEP!",
                    prefixIcon: MdiIcons.mapMarker,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      if (value.length == 8) {
                        controller.searchCep(
                            value); // Busca CEP e preenche cidade e estado
                      }
                    },
                  ),
                  CustomTextFieldContainer(
                    desableDecoration: true,
                    controller: controller.stateCtrl,
                    hintText: "Estado",
                    prefixIcon: MdiIcons.mapMarker,
                  ),
                  CustomTextFieldContainer(
                    desableDecoration: true,
                    controller: controller.cityCtrl,
                    hintText: "Cidade",
                    prefixIcon: MdiIcons.mapMarker,
                  ),
                  const SizedBox(height: 10),
                  CustomElevatedButton(
                    backgroundColor: const Color(0xFF0F052C),
                    text: "Confirmar",
                    onPressed: () async {
                      if (controller.formKey.currentState?.validate() ??
                          false) {
                        await controller.updateUserDetails(context);
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
