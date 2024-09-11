import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_pocket_saver/app/controller/login_controller.dart';
import 'package:flutter_pocket_saver/app/global/widget/custom_app_bar_widget.dart';
import 'package:flutter_pocket_saver/app/global/widget/stateful_widget.dart';
import 'package:flutter_pocket_saver/app/widgets/gradient_background_widget.dart';

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
      appBar: const CustomAppBarWidget(
        title: "Perfil",
        implyLeading: false,
      ),
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
                    ),
                  ),
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
                    width: size.width * 0.8,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 5.0),
                          title: const Text(
                            "Atualiza cadastro",
                          ),
                          trailing: IconButton(
                            onPressed: () => Navigator.of(context)
                                .pushNamed("/atualizaCadastro"),
                            icon: const Icon(Icons.keyboard_arrow_right),
                          ),
                        ),
                        const Divider(color: Colors.grey),
                        ListTile(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 5.0),
                          title: const Text(
                            "Sair",
                          ),
                          trailing: IconButton(
                            onPressed: () => controller.logout(context),
                            icon: const Icon(Icons.exit_to_app),
                          ),
                        ),
                        const Divider(color: Colors.grey),
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
