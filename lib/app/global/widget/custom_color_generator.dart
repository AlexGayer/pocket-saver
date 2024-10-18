import 'dart:math';

import 'package:flutter/material.dart';

class ColorGenerator {
  final Map<String, Color> _categoryColors = {};

  Map<String, Color> generateRandomColorsForCategories(
      List<String> categories) {
    final random = Random();

    for (var category in categories) {
      if (!_categoryColors.containsKey(category)) {
        _categoryColors[category] = Color.fromARGB(
          255,
          random.nextInt(256),
          random.nextInt(256),
          random.nextInt(256),
        );
      }
    }

    return _categoryColors;
  }
}
