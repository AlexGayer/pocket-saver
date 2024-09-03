import 'package:flutter/material.dart';
import 'package:flutter_pocket_saver/app/global/widget/custom_elevated_button.dart';
import 'package:flutter_pocket_saver/app/global/widget/custom_text_button_widget.dart';
import 'package:flutter_pocket_saver/app/widgets/gradient_background_widget.dart';
import 'package:flutter_pocket_saver/app/pages/acesso_page.dart'; // Importe a AcessoPage

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackgroundWidget(
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
            Center(
              child: Text(
                "Controle suas finanças pessoais de maneira fácil e intuitiva",
                style: Theme.of(context).textTheme.displaySmall,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            CustomElevatedButton(
              backgroundColor: const Color(0xFF0F052C),
              text: "Cadastrar",
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        const AcessoPage(isLogin: false), // Para cadastro
                  ),
                );
              },
            ),
            CustomTextButtonWidget(
              funct: () {
                return Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        const AcessoPage(isLogin: true), // Para login
                  ),
                );
              },
              title: "Já sou cadastrado",
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
