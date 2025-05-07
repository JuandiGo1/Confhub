import 'package:flutter/material.dart';

List<Widget> buildStars(double avgScore, Color color, double size) {
  List<Widget> stars = [];
  for (int i = 1; i <= 5; i++) {
    if (avgScore >= i) {
      stars.add(Icon(Icons.star, color: color, size: size));
    } else if (avgScore >= i - 0.5) {
      stars.add(Icon(Icons.star_half, color: color, size: size));
    } else {
      stars.add(Icon(Icons.star_border, color: color, size: size));
    }
  }
  return stars;
}