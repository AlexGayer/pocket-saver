import 'package:flutter/material.dart';
import 'package:flutter_pocket_saver/app/widgets/gradient_background_widget.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  @override
  Widget build(BuildContext context) {
    return const GradientBackgroundWidget(
        child: Center(
      child: Text('Analytics Page', style: TextStyle(color: Colors.white)),
    ));
  }
}
