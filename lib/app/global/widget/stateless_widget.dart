import 'package:flutter/material.dart';
import 'package:flutter_pocket_saver/di/di.dart';
import 'package:mobx/mobx.dart';

abstract class WidgetStateless<Controller extends Store>
    extends StatelessWidget {
  final Controller controller = getIt<Controller>();

  WidgetStateless({super.key});
}
