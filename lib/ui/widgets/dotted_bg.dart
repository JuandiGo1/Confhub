import 'package:flutter/material.dart';

class DottedBackground extends StatelessWidget {
  const DottedBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: CustomPaint(
        painter: _TriangularDotsPainter(),
      ),
    );
  }
}

class _TriangularDotsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    const double spacing = 40; // Espacio entre puntos
    const double radius = 6;   // Tamaño de los puntos

    // Dibujamos los puntos en una región triangular
    for (double x = 1; x < size.width ; x += spacing) {
      for (double y = 1; y < size.height / 2; y += spacing) {
        if (y <= (-size.height / (size.width*2)) * x + size.height / 2) { // Condición para que los puntos formen un triángulo
          canvas.drawCircle(Offset(x, y), radius, paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(_TriangularDotsPainter oldDelegate) => false;
}
