import 'package:flutter/material.dart';
import 'package:flutter_pocket_saver/app/widgets/gradient_background_widget.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackgroundWidget(
          child: Center(
        child: TextButton(
            onPressed: () => Navigator.of(context).pushNamed("/index"),
            child: const Text("Sair")),
      )),
    );
  }
}
