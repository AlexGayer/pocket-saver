import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_pocket_saver/app/controller/pocket_controller.dart';
import 'package:flutter_pocket_saver/app/global/widget/stateful_widget.dart';

class UserWidget extends StatefulWidget {
  const UserWidget({
    super.key,
  });

  @override
  State<UserWidget> createState() => _UserWidgetState();
}

class _UserWidgetState extends WidgetStateful<UserWidget, PocketController> {
  @override
  void initState() {
    controller.initState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Observer(
      builder: (_) => Container(
        margin: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 50,
              height: 50,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: controller.userPhotoURL.isNotEmpty
                    ? Image.network(
                        controller.userPhotoURL,
                        height: size.height,
                        width: size.width,
                        fit: BoxFit.fill,
                      )
                    : Image.asset(
                        'assets/images/batman.png',
                        height: size.height,
                        width: size.width,
                        fit: BoxFit.fill,
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                'Olá ${controller.userName}!',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
