import 'package:flutter/material.dart';

class BalanceWidget extends StatefulWidget {
  const BalanceWidget({super.key});

  @override
  State<BalanceWidget> createState() => _BalanceWidgetState();
}

class _BalanceWidgetState extends State<BalanceWidget> {
  @override
  Widget build(BuildContext context) {
    bool obscureText = false;

    toggle() {
      setState(() {
        obscureText = !obscureText;
      });
    }

    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      height: 80,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Valor em Carteira",
              style: TextStyle(color: Colors.white)),
          TextField(
            obscureText: obscureText ? false : true,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon:
                    Icon(obscureText ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  toggle();
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
