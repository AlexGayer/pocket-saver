import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_pocket_saver/app/controller/login_controller.dart';
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
    return GradientBackgroundWidget(
      child: SafeArea(
        child: Observer(
          builder: (_) => Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: const Text(
                "Editar Perfil",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.check, color: Colors.purpleAccent),
                  onPressed: () async {
                    if (controller.formKey.currentState?.validate() ?? false) {
                      await controller.updateUserDetails(context);
                    }
                  },
                ),
              ],
            ),
            body: Form(
              key: controller.formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    _buildProfileImageSection(),
                    const SizedBox(height: 30),
                    _buildPersonalInfoSection(),
                    const SizedBox(height: 30),
                    _buildAddressSection(),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileImageSection() {
    return Column(
      children: [
        GestureDetector(
          onTap: () async {
            await controller.getImageGallery();
          },
          child: Stack(
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.purpleAccent,
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: controller.pickedImage != null
                      ? Image.file(
                          File(controller.pickedImage!.path),
                          fit: BoxFit.cover,
                        )
                      : controller.userPhotoURL.isNotEmpty
                          ? Image.network(
                              controller.userPhotoURL,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Image.asset(
                                'assets/images/batman.png',
                                fit: BoxFit.cover,
                              ),
                            )
                          : Image.asset(
                              'assets/images/batman.png',
                              fit: BoxFit.cover,
                            ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.purpleAccent,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildImageSourceButton(
              icon: Icons.camera_alt,
              label: "Câmera",
              onTap: () => controller.getImageCamera(),
            ),
            const SizedBox(width: 16),
            _buildImageSourceButton(
              icon: Icons.photo_library,
              label: "Galeria",
              onTap: () => controller.getImageGallery(),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildImageSourceButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 16),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPersonalInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle("Informações Pessoais"),
        const SizedBox(height: 16),
        _buildInputField(
          controller: controller.nameCtrl,
          hintText: "Nome completo",
          validatorText: "Informe seu nome!",
          prefixIcon: MdiIcons.account,
        ),
        _buildInputField(
          controller: controller.emailCtrl,
          hintText: "Email",
          validatorText: "Informe seu email!",
          prefixIcon: MdiIcons.email,
          keyboardType: TextInputType.emailAddress,
          isEmail: true,
        ),
        _buildInputField(
          controller: controller.cpfCtrl,
          hintText: "CPF",
          validatorText: "Informe seu CPF!",
          prefixIcon: MdiIcons.cardAccountDetails,
          keyboardType: TextInputType.number,
          isCpf: true,
        ),
        GestureDetector(
          onTap: () => controller.datePicker(context),
          child: AbsorbPointer(
            child: _buildInputField(
              controller: controller.birthCtrl,
              hintText: "Data de Nascimento",
              validatorText: "Informe sua data de nascimento!",
              prefixIcon: MdiIcons.calendar,
              keyboardType: TextInputType.datetime,
            ),
          ),
        ),
        _buildInputField(
          controller: controller.phoneCtrl,
          hintText: "Telefone",
          validatorText: "Informe seu telefone!",
          prefixIcon: MdiIcons.phone,
          keyboardType: TextInputType.phone,
          isPhone: true,
        ),
      ],
    );
  }

  Widget _buildAddressSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle("Endereço"),
        const SizedBox(height: 16),
        _buildInputField(
          controller: controller.cepCtrl,
          hintText: "CEP",
          validatorText: "Informe seu CEP!",
          prefixIcon: MdiIcons.mapMarker,
          keyboardType: TextInputType.number,
          onChanged: (value) {
            if (value.length == 8) {
              controller.searchCep(value);
            }
          },
        ),
        _buildInputField(
          controller: controller.stateCtrl,
          hintText: "Estado",
          prefixIcon: MdiIcons.mapMarker,
        ),
        _buildInputField(
          controller: controller.cityCtrl,
          hintText: "Cidade",
          prefixIcon: MdiIcons.mapMarker,
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: CustomElevatedButton(
            backgroundColor: Colors.purpleAccent,
            text: "Salvar Alterações",
            onPressed: () async {
              if (controller.formKey.currentState?.validate() ?? false) {
                await controller.updateUserDetails(context);
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    String? validatorText,
    required IconData prefixIcon,
    TextInputType? keyboardType,
    bool isEmail = false,
    bool isCpf = false,
    bool isPhone = false,
    Function(String)? onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: CustomTextFieldContainer(
        desableDecoration: true,
        controller: controller,
        hintText: hintText,
        validatorText: validatorText,
        prefixIcon: prefixIcon,
        keyboardType: keyboardType,
        email: isEmail,
        cpf: isCpf,
        phone: isPhone,
        onChanged: onChanged,
      ),
    );
  }
}
