import 'package:flutter/material.dart';

class CustomAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String? title;

  const CustomAppBarWidget({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF0F052C),
      title: Text(title ?? "", style: Theme.of(context).textTheme.titleMedium),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
