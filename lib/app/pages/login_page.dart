import 'package:flutter/material.dart';
import 'package:flutter_pocket_saver/app/global/widget/custom_text_field_container.dart';
import 'package:flutter_pocket_saver/app/widgets/gradient_background_widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackgroundWidget(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Login"),
            const SizedBox(height: 10),
            const CustomTextFieldContainer(),
            const SizedBox(height: 10),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(30))),
                onPressed: () => test(),
                label: const Text("Continue com Google"),
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
              width: double.infinity,
              child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(30))),
                  onPressed: () => test(),
                  label: const Text("Continue com Apple"),
                  icon: Icon(
                    MdiIcons.apple,
                    color: Colors.white,
                    size: 30,
                  )),
            ),
          ],
        ),
      ),
    );
  }

  test() {
    print("teste");
  }
}
