import 'dart:math';
import 'dart:ui' as ui;
import 'package:antiradar/presentation/view_model/isar/models/country_model.dart';
import 'package:flutter/material.dart';

class RadarPainter extends CustomPainter {
  final ui.Image image;
  final List<Offset> points;
  final List<CountryModel> models;

  RadarPainter({
    super.repaint,
    required this.image,
    required this.points,
    required this.models,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 1.3);
    final radius = min(size.width, size.height) / 0.8;

    final paint = Paint()
      ..color = Colors.grey[800]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    // Draw circles
    for (var i = 1; i <= 3; i++) {
      canvas.drawCircle(center, radius * i / 3, paint);
    }

    final sectorPaint = Paint()
      ..color = Colors.grey[800]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    for (var i = 5.5; i < 7.5; i++) {
      final angle = i * pi / 4;
      final dx = cos(angle) * radius;
      final dy = sin(angle) * radius;
      canvas.drawLine(center, center + Offset(dx, dy), sectorPaint);
    }

    final sectorPath = Path()
      ..moveTo(center.dx, center.dy - 25)
      ..lineTo(
        center.dx + radius * cos(-pi / 2 - pi / 20),
        (center.dy - 25) + radius * sin(-pi / 2 - pi / 20),
      )
      ..arcTo(
        Rect.fromCircle(center: center, radius: radius),
        -pi / 2 - pi / 20,
        pi / 10,
        false,
      )
      ..lineTo(center.dx, center.dy - 25);

    final sectorPaintFill = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    canvas.drawPath(sectorPath, sectorPaintFill);

    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    void drawText(String text, Offset position) {
      textPainter.text = TextSpan(
        text: text,
        style: TextStyle(color: Colors.white, fontSize: 12),
      );
      textPainter.layout();
      textPainter.paint(canvas,
          position - Offset(textPainter.width / 2, textPainter.height / 0.3));
    }

    drawText('200m', Offset(center.dx, center.dy - radius / 3));
    drawText('500m', Offset(center.dx, center.dy - radius * 2 / 3));
    canvas.drawImage(image,
        Offset((size.width / 2) - 20, (size.height / 1.3) - 20), Paint());
    final pointPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    for (int i = 0; i < points.length; i++) {
      canvas.drawCircle(points[i], 5.0, pointPaint);
      drawText('${models[i].lat}, ${models[i].long}', points[i]);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
