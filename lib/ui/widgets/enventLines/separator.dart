import 'package:flutter/material.dart';

class SeparatorWithDot extends StatelessWidget {
  final Color lineColor;
  final Color dotColor;
  final double height;
  final double thickness;

  const SeparatorWithDot({
    super.key,
    this.lineColor = Colors.grey,
    this.dotColor = Colors.black,
    this.height = 1,
    this.thickness = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.centerLeft,
      child: FractionallySizedBox(
        widthFactor: 0.8,
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: thickness,
                color: lineColor,
              ),
            ),
            SizedBox(width: 4),
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: dotColor,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}