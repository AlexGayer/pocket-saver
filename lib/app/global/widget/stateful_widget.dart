import 'package:flutter/material.dart';
import 'package:flutter_pocket_saver/di/di.dart';
import 'package:mobx/mobx.dart';

abstract class WidgetStateful<Widget extends StatefulWidget,
    Controller extends Store> extends State<Widget> {
  final Controller controller = getIt<Controller>();
}
