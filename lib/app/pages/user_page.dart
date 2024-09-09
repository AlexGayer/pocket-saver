import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_pocket_saver/app/controller/login_controller.dart';
import 'package:flutter_pocket_saver/app/global/widget/custom_app_bar_widget.dart';
import 'package:flutter_pocket_saver/app/global/widget/stateful_widget.dart';
import 'package:flutter_pocket_saver/app/widgets/gradient_background_widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends WidgetStateful<UserPage, LoginController> {
  @override
  void initState() {
    controller.initState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final style = Theme.of(context).textTheme;
    return Scaffold(
      appBar: CustomAppBarWidget(
          title: "Perfil",
          implyLeading: false,
          icon: MdiIcons.exitToApp,
          func: () async => await controller.logout(context)),
      body: Observer(
        builder: (_) => GradientBackgroundWidget(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                      height: size.height * 0.2,
                      child: CircleAvatar(
                        radius: 100,
                        backgroundColor: Colors.black,
                        child: controller.userPhotoURL.isNotEmpty
                            ? ClipOval(
                                child: Image.network(
                                  controller.userPhotoURL,
                                  height: size.height,
                                  width: size.width,
                                  fit: BoxFit.fill,
                                ),
                              )
                            : Image.asset(
                                'assets/images/batman.png',
                                fit: BoxFit.fill,
                              ),
                      )),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: size.height * 0.1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(controller.userName, style: style.titleLarge),
                        Text(controller.userMail, style: style.bodyMedium)
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                  SizedBox(
                    height: size.height * 0.2,
                    child: Column(
                      children: [
                        TextButton.icon(
                            icon: Icon(MdiIcons.account),
                            onPressed: () {},
                            label: const Text("Meu Cadastro")),
                      ],
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
}
