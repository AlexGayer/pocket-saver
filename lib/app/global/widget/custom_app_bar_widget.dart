import 'package:flutter/material.dart';

class CustomAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String? title;
  final bool? implyLeading;
  final IconData? icon;
  final Function()? func;

  const CustomAppBarWidget(
      {super.key, this.title, this.implyLeading, this.icon, this.func});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: implyLeading ?? true,
      backgroundColor: const Color(0xFF0F052C),
      actions: [
        IconButton(
          onPressed: func,
          icon: Icon(icon),
        )
      ],
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text(
              title ?? "",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
