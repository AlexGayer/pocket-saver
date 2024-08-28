import 'package:flutter/material.dart';

class CustomDialogWidget {
  void show(BuildContext context, String message, {Function? func}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (func != null) {
                  func();
                }
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
