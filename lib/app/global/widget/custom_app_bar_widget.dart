import 'package:flutter/material.dart';

class CustomAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String? title;
  final bool? implyLeading;

  const CustomAppBarWidget({super.key, this.title, this.implyLeading});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: implyLeading ?? true,
      backgroundColor: const Color(0xFF0F052C),
      title: Text(title ?? "", style: Theme.of(context).textTheme.titleMedium),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
