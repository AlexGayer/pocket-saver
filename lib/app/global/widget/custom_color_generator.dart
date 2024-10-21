import 'dart:math';
import 'package:flutter/material.dart';

class ColorGenerator {
  final Map<String, Color> _categoryColors = {};

  Color generateRandomColor() {
    final random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }

  Map<String, Color> generateColorsForCategories(List<String> categories) {
    for (var category in categories) {
      if (!_categoryColors.containsKey(category)) {
        _categoryColors[category] = generateRandomColor();
      }
    }
    return _categoryColors;
  }

  void clearColors() {
    _categoryColors.clear();
  }
}
